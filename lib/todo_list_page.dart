import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/new_todo_widget.dart';
import 'package:todo_app/service_locator.dart';
import 'package:todo_app/todo_filter.dart';
import 'package:todo_app/todo_list_controller.dart';
import 'package:todo_app/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final controller = getIt<TodoListController>();

  TodoFilter selectedFilter = TodoFilter.all;

  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('To Do App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
            112,
          ), // SearchBar (56) + spacing + Segmented (56)
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Barra de pesquisa ---
                SearchBar(
                  controller: _searchCtrl, // TextEditingController
                  focusNode: _searchFocus, // FocusNode
                  hintText: 'Pesquisar tarefas…',
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (_searchCtrl.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          controller.changeSearch('');
                          setState(() {}); // atualiza trailing condicional
                        },
                      ),
                  ],
                  onChanged: (text) {
                    controller.changeSearch(text);
                    setState(() {}); // mostra/esconde o botão limpar
                  },
                ),

                const SizedBox(height: 8),

                // --- Filtros (SegmentedButton) ---
                SegmentedButton<TodoFilter>(
                  segments: const [
                    ButtonSegment(
                      value: TodoFilter.all,
                      label: Text('Todas'),
                      icon: Icon(Icons.list_alt),
                    ),
                    ButtonSegment(
                      value: TodoFilter
                          .incomplete, // ajuste para seu enum se necessário
                      label: Text('A fazer'),
                      icon: Icon(Icons.schedule),
                    ),
                    ButtonSegment(
                      value: TodoFilter
                          .completed, // ou TodoFilter.comp, conforme seu enum
                      label: Text('Concluídas'),
                      icon: Icon(Icons.check_circle),
                    ),
                  ],
                  selected: {selectedFilter},
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
                  onSelectionChanged: (newSel) {
                    final f = newSel.first;
                    if (f != selectedFilter) {
                      setState(() => selectedFilter = f);
                      controller.changeFilter(f);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: controller.filtterNotifie,
            builder: (context, filter, child) {
              if (filter == TodoFilter.completed) {
                return const SizedBox.shrink();
              }
              return NewTodoWidget();
            },
          ),

          TodoListWidget(),
        ],
      ),
    );
  }
}
