From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: libata-acpi: summary, problems, questions and proposal
Date: Thu, 29 Mar 2007 03:05:17 +0100
Message-ID: <20070329020517.GA18249@srcf.ucam.org>
References: <460A197A.9000708@gmail.com> <20070328175712.GA10293@srcf.ucam.org> <460B196B.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:43588 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbXC2CFj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 22:05:39 -0400
Content-Disposition: inline
In-Reply-To: <460B196B.5040306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Randy.Dunlap y" <rdunlap@xenotime.net>, trenn@suse.de, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, forrest.zhao@gmail.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, Mar 29, 2007 at 10:42:03AM +0900, Tejun Heo wrote:

> Yeap, I think it's in the right direction but we need to go further.
> 
> * I'm not sure whether the complex walk libata-acpi is doing is justifiable.

Yeah, that may well be less than ideal.

> * You'll end up doing _STM/_GTM on ahci controller on some BIOSen - 1. 
> it can be dangerous 2. you might get partial or incorrect mapping - 
> think about ICH8-split-to-two-PCI-fn-in-piix-mode case.

So far I haven't seen any DSDTs that include _GTM and _STM methods for 
controllers that come up flagged as ahci, though I'm perfectly willing 
to believe that they're out there...

> I think PM functions in libata-eh is better place and you also need to 
> do _GTF after _GTM during resume.

Well, "need" - I haven't actually found hardware that seems upset about 
the missing _GTF call :) But you're right, it ought to be done. Can you 
point me at the right bits of the libata-eh code? I was trying to work 
through it earlier, but keeping track of the conditional paths is a bit 
tricky.

> >I think this is just a matter of making sure that the sata and pata 
> >handle matching code matches reality now :)
> 
> Currently 1/2 of libata-acpi code is dealing with the above.  I'm trying 
> to figure out why it needs to be that complex.

I wrote a patch at one point that simplified this to an extent 
(http://lkml.org/lkml/2005/12/7/425), but it got somewhat bogged down in 
discussion about where the right place to do the binding was. Personally 
I'd prefer to handle this in a similar way to PCI - that is, register 
the ata bus with ACPI and then find handles as and when new ata devices 
are added to that bus. This has the advantage that it's easy to tie ACPI 
events to specific ata devices, which could then be integrated with the 
bay and dock drivers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
