From: David Miller <davem@davemloft.net>
Subject: Re: Multiple MSI, take 3
Date: Sun, 13 Jul 2008 20:19:06 -0700 (PDT)
Message-ID: <20080713.201906.60811176.davem@davemloft.net>
References: <1215994659.7549.227.camel@pasglop>
	<20080713.174457.82768245.davem@davemloft.net>
	<m1ej5x1at3.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <m1ej5x1at3.fsf@frodo.ebiederm.org>
Sender: linux-pci-owner@vger.kernel.org
To: ebiederm@xmission.com
Cc: benh@kernel.crashing.org, suresh.b.siddha@intel.com, matthew@wil.cx, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 13 Jul 2008 19:03:52 -0700

> At the very least you are left with the problem of allocating multiple
> contiguous destinations.  Which has the potential to create
> fragmentation on all supported platforms.

I don't think this is a very real concern.  With 256 MSI slots
available per domain, at least on sparc64, no real case can cause
problems.

And even so, drivers can and should fall back when allocations fail
anyways.

That's what drivers, at least the ones I have written, do even for
MSI-X.  For example, the NIU driver scales back the number of
MSI-X vectors it askes for if the original request cannot be
satisfied.

> My honest opinion is that the should have deprecated multi-msi after
> the introduction of the msi-x specification.

I don't think this would have materially influenced what happened with
AHCI at all.
