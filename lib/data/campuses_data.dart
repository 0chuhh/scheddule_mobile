import 'package:schedule_mobile/models/campus_model.dart';
import 'package:schedule_mobile/models/faculty_model.dart';

List<CampusModel> campuses = [
  CampusModel(
      id: 1,
      address: 'ул.Александро-Заводская, 30',
      faculties: [
        FacultyModel(
          facultyShortName: 'ФСиЭ',
          facultyFullName: 'Факультет строительства и экологии',
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
      id: 2,
      address: 'ул.Баргузинская, 49а',
      faculties: [
        FacultyModel(
          facultyShortName: 'ФЭиУ',
          facultyFullName: 'Факультет экономики и управления',
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
    id: 3,
    address: 'ул.Баргузинская, 49, корп. 1',
    faculties: [
      FacultyModel(
        facultyShortName: 'ЭФ',
        facultyFullName: 'Энергетический факультет',
      )
    ],
    bellScheduleId: 1,
  ),
  CampusModel(
    id: 4,
    address: 'ул.Баргузинская, 49, корп. 2',
    faculties: [
      FacultyModel(
        facultyShortName: 'ФТТиС',
        facultyFullName: 'Факультет технологий, трансопрта и связи',
      )
    ],
    bellScheduleId: 1,
  ),
  CampusModel(
    id: 5,
    address: 'ул.Амурская, 25',
    faculties: [
      FacultyModel(
        facultyShortName: 'ФСиЭ',
        facultyFullName: 'Факультет технологий, трансопрта и связи',
      ),
      FacultyModel(
        facultyShortName: 'ГТК',
        facultyFullName: 'Гуманитарно-технический колледж',
      )
    ],
    bellScheduleId: 1,
  ),
  CampusModel(
      id: 6,
      address: 'ул.Горького, 28, стр.1',
      faculties: [
        FacultyModel(
            facultyShortName: 'ГФ',
            facultyFullName: 'Горный факультет'
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
      id: 7,
      address: 'ул.Петровско-Заводская, 46а',
      faculties: [
        FacultyModel(
            facultyShortName: 'ЮФ',
            facultyFullName: 'Юридический факультет'
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
      id: 8,
      address: 'ул.Кастринская, 1, корп.1',
      faculties: [
        FacultyModel(
          facultyShortName: 'ФСиЭ',
          facultyFullName: 'Факультет технологий, трансопрта и связи',
        ),
        FacultyModel(
            facultyShortName: 'ФДПО',
            facultyFullName: 'Факультет дополнительного профессионального образования'
        ),
        FacultyModel(
            facultyShortName: 'Лицей',
            facultyFullName: 'Лицей'
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
      id: 9,
      address: 'ул.Кастринская, 1, корп.2',
      faculties: [
        FacultyModel(
            facultyShortName: 'ГФ',
            facultyFullName: 'Горный факультет'
        )
      ],
      bellScheduleId: 1
  ),
  CampusModel(
      id: 10,
      address: 'ул.Чкалова, 140',
      faculties: [
        FacultyModel(
            facultyShortName: 'ИФ',
            facultyFullName: 'Исторический факультет'
        ),
        FacultyModel(
            facultyShortName: 'ФФиМК',
            facultyFullName: 'Факультет филологии и массовых коммуникаций'
        ),
      ],
      bellScheduleId: 2
  ),
  CampusModel(
      id: 11,
      address: 'ул.Бабушкина, 125',
      faculties: [
        FacultyModel(
            facultyShortName: 'ФКиИ',
            facultyFullName: 'Факультет культуры и искусств'
        )
      ],
      bellScheduleId: 2
  ),
  CampusModel(
      id: 12,
      address: 'ул.Журавлева, 48',
      faculties: [
        FacultyModel(
            facultyShortName: 'ФФКиИ',
            facultyFullName: 'Факультет физической культуры и спорта'
        )
      ],
      bellScheduleId: 2
  ),
  CampusModel(
      id: 13,
      address: 'ул.Бутина, 65',
      faculties: [
        FacultyModel(
            facultyShortName: 'ФФиМК',
            facultyFullName: 'Факультет филологии и массовых коммуникаций'
        ),
      ],
      bellScheduleId: 2
  ),
  CampusModel(
      id: 14,
      address: 'ул.Бабушкина, 129',
      faculties: [
        FacultyModel(
            facultyShortName: 'ФЕНМиТ',
            facultyFullName: 'Факультет естественных наук, математики и технологий'
        ),
        FacultyModel(
            facultyShortName: 'ИСНПиП',
            facultyFullName: 'Институт социальных наук, психологии и педагогики'
        ),
      ],
      bellScheduleId: 2
  ),
  CampusModel(
    id: 15,
    address: 'ул.Чкалова, 109, пом.1',
    faculties: [
      FacultyModel(
          facultyShortName: 'ЮФ',
          facultyFullName: 'Юридический факультет'
      ),
    ],
    bellScheduleId: 1,
  )
];
