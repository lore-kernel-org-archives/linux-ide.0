From: "Ahmed S. Darwish" <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Date: Wed, 26 Jan 2011 14:49:54 +0200
Message-ID: <20110126124954.GC24527@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Willy Tarreau <wtarreau-Dj75qbTlC0E76Z2rM5mHXA@public.gmane.org>, Dirk Hohndel <hohndel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, FBDEV-ML <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, IDE-ML <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, James Bottomley <James.Bottomley-l3A5Bk7waGM@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, X86-ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, KEXEC-ML <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>Eric Biederman <e>
List-Id: linux-ide@vger.kernel.org

Hi,

On Wed, Jan 26, 2011 at 06:25:19AM +1000, Linus Torvalds wrote:
> On Tue, Jan 25, 2011 at 11:47 PM, Ahmed S. Darwish <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > As a possible solution, below patches prototypes the idea of persistently
> > storing the kernel log ring to a hard disk partition using the enhanced BIOS
> > 0x13 services.
> >
>
> Quite frankly, I'm not likely to _ever_ merge anything like this.
> 
> Over the years, many people have tried to write things to disk on
> oops. I refuse to take it. No way in hell do I want the situation of
> "the system is screwed, so let's overwrite the disk" to be something
> the kernel I release might do. It's crazy. That disk is a lot more
> important than the kernel, and overwriting it when we might have
> serious memory corruption issues or something is not a thing I feel is
> appropriate.
> 

OK, I've carefully read all the criticism posted here and in the other
replies. A short summary:

- It will be _too_ much to restore the PIC, IO-APIC, PCI configuration,
  and disk controllers to the BIOS Power-on self-test (POST) state. The
  solution will not be guaranteed to work on all machines.

- The write path of the BIOS INT 0x13 services is not tested enough by
  contemporary x86 kernels (Windows and Linux). Thus, that part of the
  BIOS is probably not as stable as I originally claimed.

Possible solutions:

- Having a minimal "fail-safe" disk controller driver to access the
  disk. This can't be made "perfect" enough to work on all combinations
  of machines (Though it can work on a small subset, e.g. the usual lot
  of x86 laptops with Intel chipsets). Linus is not OK with the _whole_
  idea of doing _any_ disk write on panic.

- Use kexec/kdump. I wonder though, can kexec work on early panics? The
  kind where the disk itself might not yet be initialized?

  If not, can kexec be modified to do so? That possibly needs the help
  of a a bootloader extension.

- The latest approach (proposed by Linus) is to forget the disk: jump to
  real-mode, but display the kernel log in a fancy format (with scroll
  ups and downs) instead.

  Will re-initializing the VGA registers to their POST state be possible?
  If not, what about a "fail-safe" VGA driver?

I'm most likely going to implement either the second or the third point,
so I'd really appreciate some input.

thanks,

> 
> If you want to do the BIOS services thing, do it for video: copy the
> oops to low RAM, return to real mode, re-run the graphics card POST
> routines to initialize text-mode, and use the BIOS to print out the
> oops.  That is WAY less scary than writing to disk.
> 
>                               Linus

-- 
Darwish
http://darwish.07.googlepages.com
