From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: document capacity hack
Date: Wed, 18 Feb 2009 21:38:14 +0100
Message-ID: <200902182138.15501.bzolnier@gmail.com>
References: <200902182018.52195.bzolnier@gmail.com> <499C62FF.1090805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:52277 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZBRUmx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 15:42:53 -0500
In-Reply-To: <499C62FF.1090805@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Wednesday 18 February 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Just copy the comment from drivers/scsi/sr.c::sr_done()
> > (from which the capacity hack has been originated).
> 
> > Cc: Borislav Petkov <petkovbb@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/ide-cd.c
> > ===================================================================
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -189,6 +189,14 @@ static void cdrom_analyze_sense_data(ide
> >  			bio_sectors = max(bio_sectors(failed_command->bio), 4U);
> >  			sector &= ~(bio_sectors - 1);
> >  
> > +			/*
> > +			 * The SCSI specification allows for the value
> > +			 * returned by READ CAPACITY to be up to 75 2K
> > +			 * sectors past the last readable block.
> 
>     Oh horror... :-)
> 
> > +			 * Therefore, if we hit a medium error within the
> > +			 * last 75 2K sectors, we decrease the saved size
> > +			 * value.
> > +			 */
> >  			if (sector < get_capacity(info->disk) &&
> >  			    drive->probed_capacity - sector < 4 * 75)
> >  				set_capacity(info->disk, sector);
> 
>     Would be nice if the CHS capacity workround was finally documented too? ;-)

Send patches.  I have my hands full of work...
