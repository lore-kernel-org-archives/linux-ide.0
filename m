From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH][pata] ide: cable detection fixes
Date: Mon, 12 Feb 2007 01:37:57 +0100
Message-ID: <200702120137.57898.bzolnier@gmail.com>
References: <200702112324.21704.bzolnier@gmail.com> <20070211230840.06c1f38b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbXBLAc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 19:32:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so440660uga
        for <linux-ide@vger.kernel.org>; Sun, 11 Feb 2007 16:32:27 -0800 (PST)
In-Reply-To: <20070211230840.06c1f38b@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>


On Monday 12 February 2007 00:08, Alan wrote:
> > * use eighty_ninty_three() in ide_ata66_check(), this actually fixes 3 bugs:
> >   - bit 13 (word 93 validity check) == 1 and bit 12 (80-wire cable test) == 0
> >     configuration was incorrectly treated as a 80-wire cable present
> 
> I think you mean bit 14 and bit 13. And for validity you must check bits

Yes, thanks for catching this, fixed now.

[ "fix drive side 80c cable check" patch description also needed fixing ]

> 14/15 together as 0x01. Code seems to have the bits right not the
> comment, but doesn't check bit 15.
> 
> You also change the IVB behaviour from assuming drives would set either
> the correct bit and/or the valid bit, to drives must always set the
> correct bit but not neccessarily valid. It would be nice to know if that
> is intentional as the original IVB hack is murky early ATA standard

For ide_ata66_check() IVB=y/n cases were interchanged when compared to
eighty_ninty_three():

* for IVB=n (the default setting) the old code required bit 14 or bit 13
  to be set which is what eighty_ninty_three() required for IVB=y before
  Tejun's patch

* for IVB=y (IVB hack on) the old code required both bits 14 and 13 to be set,
  which is what eighty_ninty_three() requires for IVB=n after Tejun's patch
  (before Tejun's patch only bit 14 was required to be set)

The old code just couldn't work for IVB, this probably has gone unnoticed
for years because ide_ata66_check() is only used for user space originated
transfer mode change requests.

> history and I am not sure what the drive id error in question actually
> was ?

I can't be sure what was the original intent of IVB hack but I have seen
a few cases when IVB hack was needed for Quantum disks which had only bit 13
set and bits 15/14 cleared.

[ it is also worth to note here that ATA4 doesn't define word 93 and
  that the pre-ATA5 proposal for the cable detection came from Quantum ]

Bart
