From: David Miller <davem@davemloft.net>
Subject: Re: Multiple MSI, take 3
Date: Sun, 13 Jul 2008 17:44:57 -0700 (PDT)
Message-ID: <20080713.174457.82768245.davem@davemloft.net>
References: <1215989044.7549.219.camel@pasglop>
	<m1tzet2wie.fsf@frodo.ebiederm.org>
	<1215994659.7549.227.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1215994659.7549.227.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: ebiederm@xmission.com, suresh.b.siddha@intel.com, matthew@wil.cx, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 14 Jul 2008 10:17:39 +1000

> On Sun, 2008-07-13 at 16:29 -0700, Eric W. Biederman wrote:
> > Ben.  Multi-MSI is a crap hardware design.  Why do you think we have
> > MSI-X?  
> 
> I know and I agree. Which is why I'd rather keep the SW crap totally
> local to the MSI support code and not add new concepts to the generic
> IRQ API such as sub-channels, for which it's really not ready for imho.
> 
> They -are- separate IRQs, just badly implemented. Besides, a large part
> of the problem is purely due to the typical x86 implementation of them,
> since for example, on most PowerPC's (and possibly other archs), they
> tend to land in the PIC as normal sources, and as such benefit from all
> the "features" of such interrupts like HW masking, affinity control,
> etc... at the PIC level.

This is how it works on sparc64 too.

The x86 system designers decided to implement multi-MSI in an
inconvenient way, it is not a "crap hardware design", merely
some (unfortunately common) implementations of it happen to be.
