From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/15] ide: drop "PIO data" argument from ide_get_best_pio_mode()
Date: Mon, 2 Jul 2007 20:14:56 +0200
Message-ID: <200707022014.57006.bzolnier@gmail.com>
References: <200706302105.20596.bzolnier@gmail.com> <468938CE.8010202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:28461 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbXGBR7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 13:59:15 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1163700ika
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 10:59:14 -0700 (PDT)
In-Reply-To: <468938CE.8010202@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 02 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Drop no longer needed "PIO data" argument from ide_get_best_pio_mode()
> >   and convert all users accordingly.
> 
> > * Remove no longer needed ide_pio_data_t.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > Index: b/drivers/ide/pci/tc86c001.c
> > ===================================================================
> > --- a/drivers/ide/pci/tc86c001.c
> > +++ b/drivers/ide/pci/tc86c001.c
> > @@ -47,7 +47,7 @@ static int tc86c001_tune_chipset(ide_dri
> >  
> >  static void tc86c001_tune_drive(ide_drive_t *drive, u8 pio)
> >  {
> > -	pio =  ide_get_best_pio_mode(drive, pio, 4, NULL);
> > +	pio = ide_get_best_pio_mode(drive, pio, 4);
> 
>     Oh, you've ruined my formatting... :'-[

Hehe, not a big lost - this line goes away in patch #13/15...

Bart
