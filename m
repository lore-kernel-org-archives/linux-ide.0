From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: linux-next: Tree for Nov 9 (build errors summary)
Date: Wed, 9 Nov 2011 15:11:36 -0500
Message-ID: <20111109201136.GA5760@phenom.dumpdata.com>
References: <20111109135826.7f8270fb7151cf7939998942@canb.auug.org.au>
 <4EBAD329.1020309@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EBAD329.1020309@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, x86 maintainers <x86@kernel.org>, Greg KH <gregkh@suse.de>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 09, 2011 at 11:23:21AM -0800, Randy Dunlap wrote:
> On 11/08/2011 06:58 PM, Stephen Rothwell wrote:
> > Hi all,
> 
> 
> 1.  on i386, when CONFIG_SMP is not enabled:
> 
> arch/x86/built-in.o: In function `hpet_setup_msi_irq':
> hpet.c:(.text+0x12114): undefined reference to `arch_setup_hpet_msi'
> hpet.c:(.text+0x12123): undefined reference to `destroy_irq'
> arch/x86/built-in.o: In function `hpet_msi_capability_lookup':
> hpet.c:(.text+0x121fb): undefined reference to `create_irq_nr'
> arch/x86/built-in.o:(.data+0x314): undefined reference to `native_setup_msi_irqs'
> arch/x86/built-in.o:(.data+0x318): undefined reference to `native_teardown_msi_irq'

This looks new. When did it start happening? err, Any idea which patch
might have caused this?
