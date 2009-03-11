From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/10] ide: move ide_map_sg() call out from ->dma_setup method
Date: Wed, 11 Mar 2009 17:36:25 +0100
Message-ID: <200903111736.26177.bzolnier@gmail.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171236.25429.25264.sendpatchset@localhost.localdomain> <49B52AE3.1030209@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:64794 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbZCKRA7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:00:59 -0400
In-Reply-To: <49B52AE3.1030209@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 09 March 2009, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Move ide_map_sg() call from ->dma_setup implementations
> > and ide_destroy_dmatable() one from *_build_dmatable() to
> > ide_dma_prepare().
> >
> > There should be no functional changes caused by this patch.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> [...]
> > Index: b/drivers/ide/au1xxx-ide.c
> > ===================================================================
> > --- a/drivers/ide/au1xxx-ide.c
> > +++ b/drivers/ide/au1xxx-ide.c
> > @@ -272,9 +272,7 @@ static int auide_build_dmatable(ide_driv
> >  	if (count)
> >  		return 1;
> >  
> > - use_pio_instead:
> > -	ide_destroy_dmatable(drive);
> > -
> > +use_pio_instead:
> >   
> 
>    Could you please get rid of goto and label too, while at it?

Sorry but since this patch has been already merged it would be too much
work/noise for too little gain IMO.
