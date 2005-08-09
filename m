From: Mark Lord <mlord@pobox.com>
Subject: Re: libata total system lockup fix
Date: Tue, 09 Aug 2005 11:16:32 -0400
Message-ID: <42F8C8D0.2010603@pobox.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41998 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964794AbVHIPQc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 11:16:32 -0400
In-Reply-To: <42F2E267.50402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Tejun,

I'm back from holiday now, and will try your one-liner
in place of the more complex patch I had been using.

(that's what you intended, right?)

Should know within a few hours whether it solves this
problem here or not.

cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


Tejun Heo wrote:
> Mark Lord wrote:
> 
>>  >The problem with this patch is that is causes leaks, and doesn't 
>> actually ready the devices because scsi_eh_ready_devs() is never 
>> called: scsi_eh_abort_cmds() is guaranteed to fail out every time its 
>> called.
>>
>> MMmm.. bummer if that's the case, but it does execute here
>> on my machine about once every two seconds, continuously,

...

>  Hello, Mark Lord.
> 
>  I think I've hit similar scsi-eh lockup problem during development of 
> new EH/NCQ helpers.  I currently don't remember where it exactly looped, 
> but I recall that scmds jumped back and forth between two lists, one of 
> which being eh_cmd_q which isn't cleared properly by SATA's strategy 
> routine.  Anyways, I'm attaching an one liner quick fix, which I'm not 
> sure if it will work or not.  Also, I'll post a combined patch of my new 
> EH/NCQ helpers in a separate mail, which, hopefully, should be free of 
> this issue.
> 
>  Please try out these two and let me know how they go.  Here's the one 
> liner against v2.6.12.
> 
> 
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
>          * appropriate place
>          */
>         host->host_failed--;
> +       INIT_LIST_HEAD(&host->eh_cmd_q);
> 
>         DPRINTK("EXIT\n");
>         return 0;


