From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Multiple MSI, take 3
Date: Sat, 12 Jul 2008 13:52:00 +1000
Message-ID: <1215834720.7549.154.camel@pasglop>
References: <20080711005719.GO14894@parisc-linux.org>
	 <m1iqvc91li.fsf@frodo.ebiederm.org>
	 <20080711215943.GW1678@linux-os.sc.intel.com>
	 <m1d4lkauxc.fsf@frodo.ebiederm.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37113 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbYGLDwo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jul 2008 23:52:44 -0400
In-Reply-To: <m1d4lkauxc.fsf@frodo.ebiederm.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>

On Fri, 2008-07-11 at 15:59 -0700, Eric W. Biederman wrote:
> Suresh Siddha <suresh.b.siddha@intel.com> writes:
> 
> > With interrupt-remapping, we can program the individual interrupt
> > remapping table entries to point to different cpu's etc. All we have
> > to take care is, do the IRTE allocation in a consecutive block and
> > program the starting index to the MSI registers.
> >
> > Just curious Eric, why do you think that won't work?
> 
> Working mask/unmask.  With MSI-X as specced if I mask an irq and then unmask
> it, an msi message will fire if something happened while the irq was masked
> and not taken care of before the irq was unmasked.  That is the correct
> behavior for an irq and a mmu won't let me get that.

And ? It's just a message, we can ignore it if masked, ie, do
software-masking. Not a big deal... no ?

Ben.


