import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Résumé Séance 4 - Programmation C',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const PresentationHome(),
    );
  }
}

class PresentationHome extends StatefulWidget {
  const PresentationHome({super.key});

  @override
  State<PresentationHome> createState() => _PresentationHomeState();
}

class _PresentationHomeState extends State<PresentationHome> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Séance 4',
      subtitle: 'Programmation C\nLes Pointeurs',
      icon: Icons.code,
      color: Colors.indigo,
    ),
    SlideData(
      title: '1. Définition des Pointeurs',
      content: [
        'Un pointeur est une variable qui contient l\'adresse mémoire d\'une autre variable',
        'Permet la manipulation directe de la mémoire',
        'Syntaxe: type *nom_pointeur;',
        'Exemple: int *ptr;',
      ],
      icon: Icons.location_on,
      color: Colors.blue,
    ),
    SlideData(
      title: '2. Déclaration et Initialisation',
      content: [
        'Déclaration: int *ptr;',
        'Opérateur & : obtenir l\'adresse d\'une variable',
        'Exemple: ptr = &variable;',
        'Opérateur * : accéder à la valeur pointée (déréférencement)',
        'Exemple: *ptr = 10;',
      ],
      icon: Icons.settings,
      color: Colors.teal,
    ),
    SlideData(
      title: '3. Opérations sur les Pointeurs',
      content: [
        '• Affectation: ptr = &var;',
        '• Déréférencement: *ptr',
        '• Arithmétique: ptr++, ptr--, ptr+n',
        '• Comparaison: ptr1 == ptr2',
        '• NULL: valeur spéciale pour pointeur non initialisé',
      ],
      icon: Icons.calculate,
      color: Colors.purple,
    ),
    SlideData(
      title: '4. Pointeurs et Tableaux',
      content: [
        'Un tableau est un pointeur vers son premier élément',
        'tab[i] équivaut à *(tab + i)',
        'Parcours avec pointeurs plus efficace',
        'Exemple: int *p = tab;',
        'Navigation: p++ pour élément suivant',
      ],
      icon: Icons.view_list,
      color: Colors.orange,
    ),
    SlideData(
      title: '5. Pointeurs et Fonctions',
      content: [
        'Passage par référence avec pointeurs',
        'Permet de modifier les variables originales',
        'Exemple: void swap(int *a, int *b)',
        'Retour de multiples valeurs',
        'Efficacité pour grandes structures',
      ],
      icon: Icons.functions,
      color: Colors.green,
    ),
    SlideData(
      title: '6. Allocation Dynamique',
      content: [
        'malloc(): allouer de la mémoire',
        'calloc(): allouer et initialiser à zéro',
        'realloc(): redimensionner la mémoire',
        'free(): libérer la mémoire allouée',
        'Important: toujours libérer la mémoire!',
      ],
      icon: Icons.memory,
      color: Colors.red,
    ),
    SlideData(
      title: '7. Erreurs Courantes',
      content: [
        '⚠️ Pointeur non initialisé (pointeur sauvage)',
        '⚠️ Déréférencement de NULL',
        '⚠️ Fuite mémoire (oubli de free)',
        '⚠️ Accès hors limites',
        '⚠️ Double libération de mémoire',
      ],
      icon: Icons.warning,
      color: Colors.deepOrange,
    ),
    SlideData(
      title: 'Points Clés à Retenir',
      content: [
        '✓ Les pointeurs stockent des adresses mémoire',
        '✓ & pour obtenir l\'adresse, * pour déréférencer',
        '✓ Essentiels pour tableaux et fonctions',
        '✓ Allocation dynamique avec malloc/free',
        '✓ Toujours initialiser et vérifier NULL',
      ],
      icon: Icons.lightbulb,
      color: Colors.amber,
    ),
  ];

  void _nextSlide() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousSlide() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return SlideWidget(slide: _slides[index]);
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? _slides[_currentPage].color
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _currentPage > 0 ? _previousSlide : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Précédent'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    Text(
                      '${_currentPage + 1} / ${_slides.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _currentPage < _slides.length - 1
                          ? _nextSlide
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Suivant'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            slide.color.withOpacity(0.1),
            slide.color.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: slide.color.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                slide.icon,
                size: 64,
                color: slide.color,
              ),
              const SizedBox(height: 24),
              Text(
                slide.title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: slide.color,
                ),
                textAlign: TextAlign.center,
              ),
              if (slide.subtitle != null) ..[
                const SizedBox(height: 16),
                Text(
                  slide.subtitle!,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (slide.content != null) ..[
                const SizedBox(height: 32),
                ...slide.content!.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: slide.color,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SlideData {
  final String title;
  final String? subtitle;
  final List<String>? content;
  final IconData icon;
  final Color color;

  SlideData({
    required this.title,
    this.subtitle,
    this.content,
    required this.icon,
    required this.color,
  });
}
