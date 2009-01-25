From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Sun, 25 Jan 2009 20:04:18 +0100
Message-ID: <200901252004.18486.bzolnier@gmail.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com> <497B9EE4.8010807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:37217 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZAYTfi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 14:35:38 -0500
Received: by nf-out-0910.google.com with SMTP id d3so964279nfc.21
        for <linux-ide@vger.kernel.org>; Sun, 25 Jan 2009 11:35:36 -0800 (PST)
In-Reply-To: <497B9EE4.8010807@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, gdu@mns.spb.ru

On Sunday 25 January 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> > When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
> > 82 of the identify data instead the word 83.  It also checks the ATA revision
> > in the  word 80 instead of usual validity check for the words 82-83 -- word 83
> > bit 14 set, bit 15 cleared.
> >
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >
> > ---
> > I'm not sure who should queue this patch... it's against Linus' tree.
> >
> >  include/linux/ata.h |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
> >
> > Index: linux-2.6/include/linux/ata.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/ata.h
> > +++ linux-2.6/include/linux/ata.h
> > @@ -734,9 +734,8 @@ static inline int ata_id_is_cfa(const u1
> >  	if (id[ATA_ID_CONFIG] == 0x848A)	/* Standard CF */
> >  		return 1;
> >  	/* Could be CF hiding as standard ATA */
> > -	if (ata_id_major_version(id) >= 3 &&
> > -	    id[ATA_ID_COMMAND_SET_1] != 0xFFFF &&
> > -	   (id[ATA_ID_COMMAND_SET_1] & (1 << 2)))
> > +	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) == 0x4000 &&
> > +	    (id[ATA_ID_COMMAND_SET_2] & (1 << 2)))
> >  		return 1;
> >  	return 0;
> >  }
> 
>    Jeff, Bart, I've changed my mind about recasting this patch as Alan 
> has requested, as I do consider it correct now. The version check should 
> be unnecessary since I'm adding the validity bits check (hte fact that 
> ata_id_major_complex() is quite cumbesome way of checking the minumum 
> revision # -- this can be done with a single comparison instead of the 
> bit scan). Note that words 64-127 were marked reserved, and must be set 
> to 0 since ATA-1. Have your say please -- do I still need to recast the 
> patch?

I'm fine with the current version -- validity checking should take care of
handling reserved words (even if they are set to 0xff) and we can always add
more detailed checks later if necessary (which is very unlikely)...

Thanks,
Bart
