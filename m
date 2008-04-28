From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Tue, 29 Apr 2008 08:11:49 +0900
Message-ID: <481659B5.7090703@gmail.com>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:57246 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967074AbYD1XL6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 19:11:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so4229687wff.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 16:11:56 -0700 (PDT)
In-Reply-To: <48164AE8.4070106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Hello, Mark.

Mark Lord wrote:
>> Are there controllers which *can* handle such a mix (ahci, sil24 ?)

Yeap, sil24 can.  ahci can currently only do device based switching but 
ahci 2.0 can do it too.

>> So it looks like a I need a .qc_defer() function which examines all links
>> from the common host port for activity, and then asks for command 
>> deferral
>> when the new command has a different protocol than those that are 
>> outstanding.
>>
>> Weird that none of the other LLDs need this.  Or do they?

So, none of the others needs this.

> This seems (below) to work for sata_mv.  But I still wonder about other 
> LLDs.
> 
> 
> static int mv_qc_defer (struct ata_queued_cmd *qc)
> {
>     struct ata_link *link = qc->dev->link;
>     struct ata_port *ap = link->ap;
>     struct mv_port_priv *pp;
>     int port_is_using_ncq;
> 
>     if (ap->nr_active_links == 0)
>         return 0;
>     pp = ap->private_data;
>     port_is_using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
>     if (qc->tf.protocol == ATA_PROT_NCQ) {
>         if (port_is_using_ncq)
>             return ata_std_qc_defer(qc);
>     } else {
>         if (!port_is_using_ncq)
>             return sata_pmp_qc_defer_cmd_switch(qc);
>     }
>     return ATA_DEFER_LINK;
> }

Looks good to me.

Thanks.

-- 
tejun
