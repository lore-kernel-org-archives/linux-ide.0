From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Fri, 11 Jul 2008 15:59:59 -0700
Message-ID: <m1d4lkauxc.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711215943.GW1678@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:36507 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYGKXCM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 19:02:12 -0400
In-Reply-To: <20080711215943.GW1678@linux-os.sc.intel.com> (Suresh Siddha's
	message of "Fri, 11 Jul 2008 14:59:43 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>

Suresh Siddha <suresh.b.siddha@intel.com> writes:

> With interrupt-remapping, we can program the individual interrupt
> remapping table entries to point to different cpu's etc. All we have
> to take care is, do the IRTE allocation in a consecutive block and
> program the starting index to the MSI registers.
>
> Just curious Eric, why do you think that won't work?

Working mask/unmask.  With MSI-X as specced if I mask an irq and then unmask
it, an msi message will fire if something happened while the irq was masked
and not taken care of before the irq was unmasked.  That is the correct
behavior for an irq and a mmu won't let me get that.

The best I can do with an iommu is to run delayed disable and set the
interrupt remapping slot in the iommu to reject the traffic.  Which
is almost but not quite what I want.

Overall introducing a new concept into the linux irq model seems a lot
cleaner and more portable, and even there we are likely to be a lot
more fragile because of the difficulty in obtaining contiguous
vectors.

Speaking of.  How many interrupt targets does the dmar iommu have
for interrupts?  16K?

Eric
