import { supabase } from './supabase'
import type { Database } from './supabase'

// Type aliases for easier use
type Tables = Database['public']['Tables']
type UserRow = Tables['users']['Row']
type ClientRow = Tables['clients']['Row']
type ProjectRow = Tables['projects']['Row']

// CRUD Operations for Users
export const userService = {
  async signIn(email, password) {
        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password,
        });

        if (error) throw error;
        if (!data.user) throw new Error("Sign in successful, but no user data returned.");

        // Now, fetch the user profile from the 'users' table
        const { data: userProfile, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('id', data.user.id)
            .single();

        if (profileError) throw profileError;
        if (!userProfile) throw new Error("User authenticated but profile not found in database.");

        return userProfile
    },
    async signOut() {
        const { error } = await supabase.auth.signOut();
        if (error) throw error;
    },
    async getCurrentUser() {
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) return null;

        const { data: userProfile, error: profileError } = await supabase
            .from('users')
            .select('*')
            .eq('id', session.user.id)
            .single();

        if (profileError) {
            console.error("Error fetching user profile:", profileError);
            return null;
        }

        return userProfile;
    },
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('vendor_id', vendorId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  },

  async create(user: Tables['users']['Insert']) {
    const { data, error } = await supabase
      .from('users')
      .insert(user)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['users']['Update']) {
    const { data, error } = await supabase
      .from('users')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('users')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  },
}

// CRUD Operations for Clients
export const clientService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .eq('vendor_id', vendorId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  },

  async getByPortalId(portalAccessId: string) {
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .eq('portal_access_id', portalAccessId)
      .single()
    
    if (error) throw error
    return data
  },

  async create(client: Tables['clients']['Insert']) {
    const { data, error } = await supabase
      .from('clients')
      .insert(client)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['clients']['Update']) {
    const { data, error } = await supabase
      .from('clients')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('clients')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// CRUD Operations for Projects
export const projectService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('projects')
      .select(`
        *,
        client:clients(*)
      `)
      .eq('vendor_id', vendorId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('projects')
      .select(`
        *,
        client:clients(*)
      `)
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  },

  async getByClientId(clientId: string) {
    const { data, error } = await supabase
      .from('projects')
      .select('*')
      .eq('client_id', clientId)
      .order('date', { ascending: false })
    
    if (error) throw error
    return data
  },

  async create(project: Tables['projects']['Insert']) {
    const { data, error } = await supabase
      .from('projects')
      .insert(project)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['projects']['Update']) {
    const { data, error } = await supabase
      .from('projects')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('projects')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// CRUD Operations for Packages
export const packageService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('packages')
      .select('*')
      .eq('vendor_id', vendorId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getPublic() {
    const { data, error } = await supabase
      .from('packages')
      .select('*')
      .order('price', { ascending: true })
    
    if (error) throw error
    return data
  },

  async create(pkg: Tables['packages']['Insert']) {
    const { data, error } = await supabase
      .from('packages')
      .insert(pkg)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['packages']['Update']) {
    const { data, error } = await supabase
      .from('packages')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('packages')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// CRUD Operations for Transactions
export const transactionService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('transactions')
      .select(`
        *,
        project:projects(project_name, client_name)
      `)
      .eq('vendor_id', vendorId)
      .order('date', { ascending: false })
    
    if (error) throw error
    return data
  },

  async create(transaction: Tables['transactions']['Insert']) {
    const { data, error } = await supabase
      .from('transactions')
      .insert(transaction)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['transactions']['Update']) {
    const { data, error } = await supabase
      .from('transactions')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('transactions')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// CRUD Operations for Team Members
export const teamMemberService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('team_members')
      .select('*')
      .eq('vendor_id', vendorId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data
  },

  async getByPortalId(portalAccessId: string) {
    const { data, error } = await supabase
      .from('team_members')
      .select('*')
      .eq('portal_access_id', portalAccessId)
      .single()
    
    if (error) throw error
    return data
  },

  async create(member: Tables['team_members']['Insert']) {
    const { data, error } = await supabase
      .from('team_members')
      .insert(member)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['team_members']['Update']) {
    const { data, error } = await supabase
      .from('team_members')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('team_members')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// CRUD Operations for Leads
export const leadService = {
  async getAll(vendorId: string) {
    const { data, error } = await supabase
      .from('leads')
      .select('*')
      .eq('vendor_id', vendorId)
      .order('date', { ascending: false })
    
    if (error) throw error
    return data
  },

  async create(lead: Tables['leads']['Insert']) {
    const { data, error } = await supabase
      .from('leads')
      .insert(lead)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async update(id: string, updates: Tables['leads']['Update']) {
    const { data, error } = await supabase
      .from('leads')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async delete(id: string) {
    const { error } = await supabase
      .from('leads')
      .delete()
      .eq('id', id)
    
    if (error) throw error
  }
}

// Profile Service
export const profileService = {
  async get(vendorId: string) {
    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('vendor_id', vendorId)
      .single()
    
    if (error) throw error
    return data
  },

  async update(vendorId: string, updates: Tables['profiles']['Update']) {
    const { data, error } = await supabase
      .from('profiles')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('vendor_id', vendorId)
      .select()
      .single()
    
    if (error) throw error
    return data
  },

  async create(profile: Tables['profiles']['Insert']) {
    const { data, error } = await supabase
      .from('profiles')
      .insert(profile)
      .select()
      .single()
    
    if (error) throw error
    return data
  }
}

// Utility function to handle real-time subscriptions
export const subscribeToTable = (
  tableName: string,
  vendorId: string,
  callback: (payload: any) => void
) => {
  return supabase
    .channel(`${tableName}_changes`)
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: tableName,
        filter: `vendor_id=eq.${vendorId}`
      },
      callback
    )
    .subscribe()
}

// Error handling utility
export const handleSupabaseError = (error: any) => {
  console.error('Supabase error:', error)
  
  if (error.code === 'PGRST116') {
    return 'Data tidak ditemukan'
  }
  
  if (error.code === '23505') {
    return 'Data sudah ada (duplikat)'
  }
  
  if (error.code === '23503') {
    return 'Data terkait tidak ditemukan'
  }
  
  return error.message || 'Terjadi kesalahan pada database'
}