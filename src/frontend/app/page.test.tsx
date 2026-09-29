import React from 'react'
import { renderToStaticMarkup } from 'react-dom/server'
import { describe, expect, it } from 'vitest'

import Page from './page'

describe('Page', () => {
  it('renders the AI HomeOps landing page', () => {
    const markup = renderToStaticMarkup(<Page />)

    expect(markup).toContain('AI HomeOps')
    expect(markup).toContain('Backend is ready to be connected.')
  })
})
