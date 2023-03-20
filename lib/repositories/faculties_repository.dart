import 'package:schedule_mobile/data/campuses_data.dart';
import 'package:schedule_mobile/models/campus_model.dart';

class CampusesRepository {
  List<CampusModel> getCampuses() {
    return campuses;
  }

  CampusModel getCampusById(int id) {
    return campuses.firstWhere((campus) => campus.id == id);
  }
}

