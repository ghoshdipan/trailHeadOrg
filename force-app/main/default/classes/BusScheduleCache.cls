/**
 * @description       : Use Org & Session Cache trail
 * @author            : Dipan Ghosh
 * @group             : 
 * @last modified on  : 01-07-2024
**/
public with sharing class BusScheduleCache {
    private Cache.OrgPartition part;
    public BusScheduleCache() {
        this.part = Cache.Org.getPartition('local.BusSchedule');
    }

    public void putSchedule(String busLine, Time[] schedule){
        part.put(busLine, schedule);
    }
    public Time[] getSchedule(String busLine){
        Object val = part.get(busLine);
        Time[] schedule = new Time[]{};
        if(val == null){
            schedule.add(Time.newInstance(8,0,0,0));
            schedule.add(Time.newInstance(17,0,0,0));
        }else{
            schedule = (Time[]) val;
        }
        return schedule;
    }
}