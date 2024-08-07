package mclass.store.tripant.trip.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import mclass.store.tripant.trip.domain.TripListEntity;
import mclass.store.tripant.trip.domain.TripShareEntity;
import mclass.store.tripant.trip.model.repository.TripListRepository;

@Service
@RequiredArgsConstructor
public class TripListService {
	
	private final TripListRepository repository;
	
	//여행목록
	public List<TripListEntity> selectTripList(String memEmail) throws DataAccessException{
		return repository.selectTripList(memEmail);
	}
	
	//여행삭제(planId -> PK)
	public int delete(Integer planId)  throws DataAccessException{
		return repository.delete(planId);
	}
	public int deleteRole(Map<String, Object> map)  throws DataAccessException{
		return repository.deleteRole(map);
	}
	
	//유저검색
	public List<TripShareEntity> find(Map<String, Object> map) throws DataAccessException{
		return repository.find(map);
	}
	
	//일정 공유 중인 맴버
	public List<TripShareEntity> share(Map<String, Object> map) throws DataAccessException{
		return repository.share(map);
	}
	
	//유저 추가
	public int add(Map<String, Object> map) throws DataAccessException{
		return repository.add(map);
	}
	
	//유저 삭제
	public int remove(Map<String, Object> map) throws DataAccessException{
		return repository.remove(map);
	}
}
