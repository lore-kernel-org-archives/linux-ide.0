From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Sun, 13 Jul 2008 15:30:43 -0700
Message-ID: <m1iqv9a030.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711215943.GW1678@linux-os.sc.intel.com>
	<m1d4lkauxc.fsf@frodo.ebiederm.org>
	<1215834720.7549.154.camel@pasglop>
	<m13amf3eak.fsf@frodo.ebiederm.org>
	<1215848161.7549.166.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:44409 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbYGMWcS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jul 2008 18:32:18 -0400
In-Reply-To: <1215848161.7549.166.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Sat, 12 Jul 2008 17:36:01 +1000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> I still mostly dislike the new approach, I prefer Matthew's original one
> with SW masking of the MSIs. For example, if you have the MSIs be 'one'
> interrupt, then you hit all of the logic in the IRQ core to make sure
> only one happens at once. Might not be what you want, and -will- cause
> some to be dropped... not nice.

You are correct.  Using the existing irq handling logic will cause us
to drop irqs and to loose information if two messages are sent close
to each other.  Which is very nasty.

With a little care we can avoid that problem by having a 32 bit bitmap
of which sub irqs have fired so we can make all of them pending
without loosing information.  That does requires a new handle_irq method.

One of the primary purposes of masking irqs in hardware is to prevent
them from screaming.  Unlikely with edge triggered irqs but not a capability
I would like to give up.

Multi-msi has the problem that cpu affinity can not be changed on a
per message basis without an iommu.  Which is a portability problem
and a problem on common architectures.

Therefore to support multi-msi it must be handled as a special case, we can not
treat the individual messages like normal irqs.

Eric
