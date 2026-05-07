import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '31 Minutos Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE63946)),
        useMaterial3: true,
      ),
      home: const QuizPage(),
    );
  }
}


const questions = [
  {
    'text': '¿Cuál es tu rol en un grupo?',
    'answers': [
      {'text': 'El líder que toma decisiones', 'char': 'Tulio'},
      {'text': 'El que investiga y reporta todo', 'char': 'Bodoque'},
      {'text': 'El que apoya a todos', 'char': 'Juanin'},
      {'text': 'El de las ideas explosivas', 'char': 'Maguito'},
      {'text': 'El que va a su propio ritmo', 'char': 'Calcetin'},
    ],
  },
  {
    'text': '¿Qué harías un viernes por la noche?',
    'answers': [
      {'text': 'Ver las noticias', 'char': 'Tulio'},
      {'text': 'Ir al hipódromo', 'char': 'Bodoque'},
      {'text': 'Trabajara hasta tarde', 'char': 'Juanin'},
      {'text': 'Hacer un show de magia', 'char': 'Maguito'},
      {'text': 'Luchar contra el mal', 'char': 'Calcetin'},
    ],
  },
  {
    'text': '¿Cómo reaccionas ante un problema?',
    'answers': [
      {'text': 'Me miro al espejo', 'char': 'Tulio'},
      {'text': 'Acepto un trabajo como periodista', 'char': 'Bodoque'},
      {'text': 'AHHHHH... estamos al aire, estamos al aireee', 'char': 'Juanin'},
      {'text': 'Haciendo un chow', 'char': 'Maguito'},
      {'text': 'Con calma, algo saldrá', 'char': 'Calcetin'},
    ],
  },
  {
    'text': '¿Cuál es tu mayor defecto?',
    'answers': [
      {'text': 'No tengo', 'char': 'Tulio'},
      {'text': 'Soy muy flojo', 'char': 'Bodoque'},
      {'text': 'No se como relajarme', 'char': 'Juanin'},
      {'text': 'Ansiedad', 'char': 'Maguito'},
      {'text': 'Tener rombos', 'char': 'Calcetin'},
    ],
  },
  {
    'text': '¿Qué frase te describe?',
    'answers': [
      {'text': '"¡Vivimos de la desgracia ajena!"', 'char': 'Tulio'},
      {'text': '"No es una adicción, es un estilo de vida."', 'char': 'Bodoque'},
      {'text': '"¡Sano como manzano!"', 'char': 'Juanin'},
      {'text': '"¡Mi chow, quiero hacer mi chow!"', 'char': 'Maguito'},
      {'text': '"¡La justicia nunca duerme!"', 'char': 'Calcetin'},
    ],
  },
];

const results = {
  'Tulio': {
    'name': 'Tulio Triviño',
    'image': 'https://i.pinimg.com/736x/ef/79/59/ef7959d908278af55ce4f6b84586e86c.jpg',
    'desc': 'Carismático y siempre al mando. Te encanta ser el centro de atención y que todo salga como lo planeaste.',
    'color': 0xFFE63946,
  },
  'Bodoque': {
    'name': 'Juan Carlos Bodoque',
    'image': 'https://i.pinimg.com/originals/e0/48/c7/e048c7e5b3aab42a6e6d249e644cb69b.jpg',
    'desc': 'Curioso e incansable. La verdad es lo más importante para ti, aunque tu lengua va más rápido que tu cerebro.',
    'color': 0xFF457B9D,
  },
  'Juanin': {
    'name': 'Juanín Juan Harry',
    'image': 'https://i.pinimg.com/originals/e9/f4/23/e9f4235dd335c62e48fd586aab22d420.jpg', 
    'desc': 'El más buena onda del grupo. Siempre dispuesto a ayudar y el que todos quieren tener cerca.',
    'color': 0xFF2A9D8F,
  },
  'Maguito': {
    'name': 'Maguito Explosivo',
    'image': 'https://i.pinimg.com/474x/23/71/f0/2371f0dbc6d217f96fe93821bc008f5c.jpg',  
    'desc': 'El genio (peligroso) del grupo. Tus ideas son brillantes en teoría... en la práctica suelen explotar.',
    'color': 0xFFE9A820,
  },
  'Calcetin': {
    'name': 'Calcetín con Rombos Man',
    'image': 'https://i.pinimg.com/736x/71/18/60/711860e6347e4438a99bb2d42e45c64d.jpg', 
    'desc': 'El más cool y relajado. Tienes tu propio estilo, vas a tu ritmo y eres el personaje con más onda.',
    'color': 0xFF6A4C93,
  },
};


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _current = 0;
  final Map<String, int> _scores = {
    'Tulio': 0, 'Bodoque': 0, 'Juanin': 0, 'Maguito': 0, 'Calcetin': 0,
  };
  String? _result;

  void _pick(String char) {
    _scores[char] = _scores[char]! + 1;
    if (_current < questions.length - 1) {
      setState(() => _current++);
    } else {
      final winner = _scores.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      setState(() => _result = winner);
    }
  }

  void _restart() => setState(() {
        _current = 0;
        _scores.updateAll((_, __) => 0);
        _result = null;
      });

  @override
  Widget build(BuildContext context) =>
      _result != null ? ResultPage(result: _result!, onRestart: _restart) : _buildQuiz();

  Widget _buildQuiz() {
    final q = questions[_current];
    final answers = q['answers'] as List;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 30, 46),
        foregroundColor: const Color.fromARGB(255, 229, 184, 49),
        centerTitle: true,
        title: const Text('¿Qué personaje de 31 Minutos eres?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_current + 1) / questions.length,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: const Color(0xFFDEE2E6),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFE63946)),
            ),
            const SizedBox(height: 6),
            Text('${_current + 1} / ${questions.length}',
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 24),

            Text(q['text'] as String,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 1.4)),
            const SizedBox(height: 20),

            ...answers.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _pick(a['char'] as String),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF212529),
                        elevation: 2,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(a['text'] as String,
                          style: const TextStyle(fontSize: 15)),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String result;
  final VoidCallback onRestart;
  const ResultPage({super.key, required this.result, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final data = results[result]!;
    final color = Color(data['color'] as int);

    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¡Eres...',
                    style: TextStyle(color: Colors.white70, fontSize: 20)),
                const SizedBox(height: 16),


                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data['image'] as String,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                Text(data['name'] as String,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(data['desc'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15, height: 1.6)),
                ),
                const SizedBox(height: 28),

                ElevatedButton.icon(
                  onPressed: onRestart,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Volver a intentarlo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}