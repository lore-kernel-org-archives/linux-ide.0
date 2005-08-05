From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 05 Aug 2005 12:52:07 +0900
Message-ID: <42F2E267.50402@gmail.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.206]:56758 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262842AbVHEDwO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Aug 2005 23:52:14 -0400
Received: by rproxy.gmail.com with SMTP id r35so485137rna
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2005 20:52:13 -0700 (PDT)
In-Reply-To: <42E50AE9.3000207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Mark Lord wrote:
>  >The problem with this patch is that is causes leaks, and doesn't 
> actually ready the devices because scsi_eh_ready_devs() is never called: 
> scsi_eh_abort_cmds() is guaranteed to fail out every time its called.
> 
> MMmm.. bummer if that's the case, but it does execute here
> on my machine about once every two seconds, continuously,
> for hours on end, and the DVD-RW drive still works when
> I eventually do place a disc into it later on.
> 
> I suppose the bug isn't seen more commonly because libata is
> the only (?) SCSI LLD that supplies it's own eh strategy function.
> Or are there other users of that interface now?
> 
> I'm off on holiday for the next while, but I'll check in on this
> again when I get back.  Perhaps the originator of this patch could
> chip in with some of the fixes, if you point out where the "leaks" are.
> 
>  >Ahha.. here's the header from the original email for this patch
>  >Subject: [PATCH] Fix SATA ATAPI error handling
>  >From: Hannes Reinecke <hare@suse.de>
>  >Date: Wed, 23 Mar 2005 16:28:16 +0100
>  >To: SCSI Mailing List <linux-scsi@vger.kernel.org>
>  >CC: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
>  >Jens Axboe <axboe@suse.de>, Kurt Garloff <garloff@suse.de>:
> 

  Hello, Mark Lord.

  I think I've hit similar scsi-eh lockup problem during development of 
new EH/NCQ helpers.  I currently don't remember where it exactly looped, 
but I recall that scmds jumped back and forth between two lists, one of 
which being eh_cmd_q which isn't cleared properly by SATA's strategy 
routine.  Anyways, I'm attaching an one liner quick fix, which I'm not 
sure if it will work or not.  Also, I'll post a combined patch of my new 
EH/NCQ helpers in a separate mail, which, hopefully, should be free of 
this issue.

  Please try out these two and let me know how they go.  Here's the one 
liner against v2.6.12.


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
          * appropriate place
          */
         host->host_failed--;
+       INIT_LIST_HEAD(&host->eh_cmd_q);

         DPRINTK("EXIT\n");
         return 0;
