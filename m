From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: libata-core: Add support for ATA_HORKAGE_DIAGNOSTIC
Date: Fri, 9 Mar 2007 14:03:18 +0000
Message-ID: <20070309140318.174a95b3@lxorguk.ukuu.org.uk>
References: <20070308231804.110f76a0@lxorguk.ukuu.org.uk>
	<45F15781.7090402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37988 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767247AbXCIM7o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 07:59:44 -0500
In-Reply-To: <45F15781.7090402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

> > -                if (print_info) {
> > +                if (print_info && !(ata_device_blacklisted(dev) & ATA_HORKAGE_DIAGNOSTIC)) {
> >  			ata_dev_printk(dev, KERN_WARNING,
> >  "Drive reports diagnostics failure. This may indicate a drive\n");
> >  			ata_dev_printk(dev, KERN_WARNING,
> 
> I don't understand this one at all.
> 
> The original point of the message was to poke people so that they poke 
> their vendors into fixing the firmware, which is indeed non-spec.  I 
> would rather not silence a "your device is operating out-of-spec" warning.

The moment it goes near a business oriented distribution this becomes a
problem because the flack all lands on either the system vendor or the OS
product vendor both of whom will simply delete the check. At least this
way it stays in for cases that actually matter.

Alan
