From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Tue, 8 Feb 2011 14:12:39 +0000
Message-ID: <20110208141239.28d80615@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
	<20110208132518.300bb098@lxorguk.ukuu.org.uk>
	<AANLkTimYbC+zgnct9j75WNR7f4M4m2=hYvODUm9mc-3W@mail.gmail.com>
	<20110208133922.6cf8142e@lxorguk.ukuu.org.uk>
	<AANLkTik744+r8y1FK9P6-aOcH0OMLyg5nvfJb2ZBVSdv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38893 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754416Ab1BHOJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 09:09:06 -0500
In-Reply-To: <AANLkTik744+r8y1FK9P6-aOcH0OMLyg5nvfJb2ZBVSdv@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> respect some of my time spent on all this burdensome silly little
> driver differences comparisons and read the whole patch set before
> making comments on individual changes (which you certainly haven't
> done given timing of your review mails and complexity of changes)..

I was hoping you'd improved but apparently not.

Any untested change is dangerous. An untested change that merges driver=
s
together simply means you can break lots of stuff for no gain at all.

If these were all PCI card devices it might make some sense but given
they are all motherboard chipsets putting them into one driver merely
increases memory use as well.

As far as stuff like=20

 =A0 unsigned int has_sitre =A0=3D (dev->vendor !=3D 0x8086 ||
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev=
->device !=3D 0x1230);

and the even worse mess you generate with the added patch all the other
PIIX code does this by flags, and if you had a HAS_SITRE (or NO_SITRE)
flag in the device data it would be obvious to anyone reading stuff how
it all fitted together.

Alan


