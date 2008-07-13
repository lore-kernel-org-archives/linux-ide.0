From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Multiple MSI, take 3
Date: Sun, 13 Jul 2008 16:29:45 -0700
Message-ID: <m1tzet2wie.fsf@frodo.ebiederm.org>
References: <20080711005719.GO14894@parisc-linux.org>
	<m1iqvc91li.fsf@frodo.ebiederm.org>
	<20080711215943.GW1678@linux-os.sc.intel.com>
	<m1d4lkauxc.fsf@frodo.ebiederm.org>
	<1215834720.7549.154.camel@pasglop>
	<m13amf3eak.fsf@frodo.ebiederm.org>
	<1215848161.7549.166.camel@pasglop>
	<m1iqv9a030.fsf@frodo.ebiederm.org>
	<1215989044.7549.219.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1215989044.7549.219.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Mon, 14 Jul 2008 08:44:04 +1000")
Sender: linux-pci-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
List-Id: linux-ide@vger.kernel.org


Ben.  Multi-MSI is a crap hardware design.  Why do you think we have
MSI-X?  MSI-X as specced is a properly operating irq controller that
we don't need kludges to support.  Multi-MSI with a full set of
kludges almost work but not quite fits the linux irq model.

Any hardware designer who choose to implement Multi-MSI instead of
MSI-X was not really concerned about having a high performance device.

If we can find a way to model the portable capabilities of Multi-MSI
cleanly then we can support it, and our drivers and our users and our
intermediate layers won't get surprised.

So far we have too close fits but neither model really works.

Further this is all about driver optimization, so none of this is
necessary to have working hardware.  Which makes kludges much less
appropriate.  Modelling Multi-MSI irqs as normal irqs requires a lot
of nasty kludges.

One of the kludges is allocating a continuous chunk of irq targets,
and the resulting fragmentation issues that you get when you start
allowing different sized allocations.

Overall if Multi-MSI was to become common I think we would really
regret it.

Eric
