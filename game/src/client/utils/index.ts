export const Delay = (ms: number): Promise<void> => new Promise(res => setTimeout(res, ms));

export const isPedFreemodeModel = (ped: number): boolean => {
  const entityModel = GetEntityModel(ped);

  const freemodeMale = GetHashKey('mp_m_freemode_01');
  const freemodeFemale = GetHashKey('mp_f_freemode_01');

  return entityModel === freemodeMale || entityModel === freemodeFemale;
};

export function arrayToVector3(coords: number[]): Vector3 {
  return {
    x: coords[0],
    y: coords[1],
    z: coords[2],
  };
}

export const getPedStats = (ped: number): Array<number> => {
  const health = GetEntityHealth(ped);
  const armor = GetPedArmour(ped);

  return [health, armor];
};

export const setPedStats = (health: number, armor: number): void => {
  const playerPed = PlayerPedId();
  SetEntityHealth(playerPed, health);
  SetPedArmour(playerPed, armor);
};
