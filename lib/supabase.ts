import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Database types (generated from schema)
export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          email: string
          password: string
          full_name: string
          company_name: string | null
          role: 'Admin' | 'Member'
          permissions: string[]
          vendor_id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          email: string
          password: string
          full_name: string
          company_name?: string | null
          role: 'Admin' | 'Member'
          permissions?: string[]
          vendor_id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          password?: string
          full_name?: string
          company_name?: string | null
          role?: 'Admin' | 'Member'
          permissions?: string[]
          vendor_id?: string
          created_at?: string
          updated_at?: string
        }
      }
      clients: {
        Row: {
          id: string
          name: string
          email: string
          phone: string
          whatsapp: string | null
          instagram: string | null
          since: string
          status: string
          client_type: string
          last_contact: string
          portal_access_id: string
          vendor_id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          email: string
          phone: string
          whatsapp?: string | null
          instagram?: string | null
          since?: string
          status?: string
          client_type?: string
          last_contact?: string
          portal_access_id?: string
          vendor_id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          email?: string
          phone?: string
          whatsapp?: string | null
          instagram?: string | null
          since?: string
          status?: string
          client_type?: string
          last_contact?: string
          portal_access_id?: string
          vendor_id?: string
          created_at?: string
          updated_at?: string
        }
      }
      // Add other table types as needed...
    }
  }
}