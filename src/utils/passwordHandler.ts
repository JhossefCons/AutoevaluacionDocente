import bcryptjs from 'bcryptjs';

export const encryptPassword = async(password: string) => await bcryptjs.hash(password, 8);

export const comparePassword = async(password: string, comparePasswor: string) => await bcryptjs.compare(password, comparePasswor);