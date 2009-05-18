From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Mon, 18 May 2009 16:45:24 +0200
Message-ID: <200905181645.26305.arnd@arndb.de>
References: <200905172138.55145.arnd@arndb.de> <200905172245.23774.arnd@arndb.de> <20090518194443R.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090518194443R.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: jgarzik@pobox.com, hancockrwd@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Monday 18 May 2009, FUJITA Tomonori wrote:
> 
> NACK'ed, sorry.

I had no idea how hard it would get to fix a simple
allyesconfig build error. This is the third time
that a new approach to getting ATA to build on all
platforms is gets a NAK...

> - these idndef tricks are really ugly and wrong.
> - these functions are not generic at all.

I was trying to do two things at once:

- provide a default implementation for each function
  that an architecture can override, therefore the
  #ifdef magic.
- Have a minimal working implementation of the API
  that at least makes sense for architectures that
  do not support DMA, but want to share some of the
  code.

Ten of the existing architectures simply try do a
linear mapping, and that should easily be possible
in a generic way not too different from what I posted.
Would you agree to a patch that works with the same
code on e.g. arm, microblaze, mn10300 and sh and
uses only a few #ifdefs?

> - it's confusing to have two ways to handle this issue;
> dma-mapping-broken.h and dma-mapping.h.

We actually already have three ways to handle this right
now:

- dma-mapping-broken.h:
  only used on Sun3 m68k, i.e. not interesting any more,
  plus it does not solve the question of how to build
  ATA drivers on architectures without DMA.
- selecting NO_DMA:
  This works fine for everything except ATA. All other
  drivers using dma-mapping.h either depend on HAS_DMA
  or sprinkle their files with #ifdef.
- adding a bogus dma-mapping.h: cris, um and microblaze
  currently set HAS_DMA but add a dma-mapping.h that
  allows stuff to compile but cannot actually work.

I think that dma-mapping-broken.h has served its purpose
and we should now have two implementations in asm-generic,
the one you posted recently for ia64, x86, parisc, powerpc
and sparc64 and one for all architectures that only have
linear mappings. The version I posted is certainly not
generic enough for those, but I can keep improving it.

	Arnd <><
