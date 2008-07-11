From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 16:59:42 -0700
Message-ID: <m163rc6kgh.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711215943.GW1678@linux-os.sc.intel.com>
	<m1d4lkauxc.fsf@frodo.ebiederm.org>
	<20080711231543.GY1678@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080711231543.GY1678@linux-os.sc.intel.com> (Suresh Siddha's
	message of "Fri, 11 Jul 2008 16:15:43 -0700")
Sender: linux-pci-owner@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
List-Id: linux-ide@vger.kernel.org

Suresh Siddha <suresh.b.siddha@intel.com> writes:

> And why do we need to mask/unmask the device in the interrupt-remapping case?

Why do we ever?  It is part of the linux irq API and people wind up using
it in all kinds of strange ways.

One of the more surprising uses I have see is for the real time kernel
people mask the irq, wake up a kernel thread (to handle the irq), then
ack the irq and get out of the interrupt handler.  It looked like
people working on UIO were starting to implement something similar.

>> Speaking of.  How many interrupt targets does the dmar iommu have
>> for interrupts?  16K?
>
> There can be multiple interrupt-remapping units in the platform and
> each of table in the remapping unit has max 64K entries.

Thanks.  That should last us for a little while. :)

Eric
