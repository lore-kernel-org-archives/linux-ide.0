From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Sun, 13 Jul 2008 19:03:52 -0700
Message-ID: <m1ej5x1at3.fsf@frodo.ebiederm.org>
References: <1215989044.7549.219.camel@pasglop>
	<m1tzet2wie.fsf@frodo.ebiederm.org>
	<1215994659.7549.227.camel@pasglop>
	<20080713.174457.82768245.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080713.174457.82768245.davem@davemloft.net> (David Miller's
	message of "Sun, 13 Jul 2008 17:44:57 -0700 (PDT)")
Sender: linux-pci-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, suresh.b.siddha@intel.com, matthew@wil.cx, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> The x86 system designers decided to implement multi-MSI in an
> inconvenient way, it is not a "crap hardware design", merely
> some (unfortunately common) implementations of it happen to be.

To be clear I was referring to the PCI spec that describes multi-MSI
as a crap hardware design.

At the very least you are left with the problem of allocating multiple
contiguous destinations.  Which has the potential to create
fragmentation on all supported platforms.

Optional mask bits are also nasty.

My honest opinion is that the should have deprecated multi-msi after the
introduction of the msi-x specification.

Eric
