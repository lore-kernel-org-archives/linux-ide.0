From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/10] ide: move ide_map_sg() call out from ->dma_setup method
Date: Wed, 11 Mar 2009 18:36:26 +0100
Message-ID: <200903111836.27062.bzolnier@gmail.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <200903111736.26177.bzolnier@gmail.com> <49B7F074.2080807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:36620 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZCKReA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:34:00 -0400
In-Reply-To: <49B7F074.2080807@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 11 March 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>Move ide_map_sg() call from ->dma_setup implementations
> >>>and ide_destroy_dmatable() one from *_build_dmatable() to
> >>>ide_dma_prepare().
> 
> >>>There should be no functional changes caused by this patch.
> 
> >>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> >>[...]
> >>
> >>>Index: b/drivers/ide/au1xxx-ide.c
> >>>===================================================================
> >>>--- a/drivers/ide/au1xxx-ide.c
> >>>+++ b/drivers/ide/au1xxx-ide.c
> >>>@@ -272,9 +272,7 @@ static int auide_build_dmatable(ide_driv
> >>> 	if (count)
> >>> 		return 1;
> >>> 
> >>>- use_pio_instead:
> >>>-	ide_destroy_dmatable(drive);
> >>>-
> >>>+use_pio_instead:
> 
> >>   Could you please get rid of goto and label too, while at it?
> 
> > Sorry but since this patch has been already merged
> 
>     Merged where?!

To pata tree, two weeks ago.

I try to limit touching merged stuff as much as possible so people working
with pata tree don't get surprised too much (sometimes it is impossible but
this doesn't discourage me from trying).  

[ Some people may argue that existing stuff shouldn't change at all but
  IMO it is all case specific and this trade-off is acceptable for fixing
  regressions / preserving bisectability... ]

> > it would be too much work/noise for too little gain IMO.
> 
>     Will you take a reworked patch from me?

Well, OK this time if it won't cause rejects in later patches... though stuff
like that is really much more efficient done in incremental patches.

Thanks,
Bart
