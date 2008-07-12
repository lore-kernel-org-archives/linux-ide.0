From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 21:41:07 -0700
Message-ID: <m13amf3eak.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711215943.GW1678@linux-os.sc.intel.com>
	<m1d4lkauxc.fsf@frodo.ebiederm.org>
	<1215834720.7549.154.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1215834720.7549.154.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Sat, 12 Jul 2008 13:52:00 +1000")
Sender: linux-pci-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
List-Id: linux-ide@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2008-07-11 at 15:59 -0700, Eric W. Biederman wrote:
>> 
>> Working mask/unmask.  With MSI-X as specced if I mask an irq and then unmask
>> it, an msi message will fire if something happened while the irq was masked
>> and not taken care of before the irq was unmasked.  That is the correct
>> behavior for an irq and a mmu won't let me get that.
>
> And ? It's just a message, we can ignore it if masked, ie, do
> software-masking. Not a big deal... no ?

It is edge triggered so it won't refire when unmasked (especially if we don't know).
So it is easy to wind up in a state where the device is waiting for the software
and the software is waiting for the device because an irq gets dropped.

There are enough places that have problems that we have a fairly standard work around
to the problem (listed above) by just taking the first irq (after we have disabled the
irq) and setting it pending in software and then actually masking it in hardware.

That works, but it is still isn't quite correct.  Because we can run the
interrupt handler once to often.  For interrupts that are never shared and
always in order with the DMA, generally don't require reading a status
register on the card, and are otherwise highly optimized that might actually
be a problem.

Which is why I said that it doesn't look like even using an iommu can
fix all of the issues with treating msi multi message mode messages
as individual irqs.  We can get very close but not quite there.

Eric
