From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 03:06:33 -0700
Message-ID: <m1iqvc91li.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080711005719.GO14894@parisc-linux.org> (Matthew Wilcox's
	message of "Thu, 10 Jul 2008 18:57:19 -0600")
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com
List-Id: linux-ide@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> I'd like to thank Michael Ellerman for his feedback.  This is a much
> better patchset than it used to be.

There is a reason we don't have an API to support this.  Linux can not
reasonably support this, especially not on current X86.  The designers
of the of the AHCI were idiots and should have used MSI-X.

Attempting to support multiple irqs in an MSI capability breaks
every interesting use of an irq.

mask/unmask is will likely break because the mask bit is optional
and when it is not present we disable the msi capability.

We can not set the affinity individually so we can not allow
different queues to be processed on different cores.

So in general it seems something that we have to jump through a million
hurdles and the result is someones twisted parody of a multiple working
irqs, that even Intel's IOMMU can't cure.

So unless the performance of the AHCI is better by a huge amount I don't
see the point, and even then I am extremely sceptical.

Eric
