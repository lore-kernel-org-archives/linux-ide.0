From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Wed, 02 Apr 2008 11:31:30 +0900
Message-ID: <47F2F002.9070401@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:61729 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYDBCbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 22:31:41 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1625641wra.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 19:31:39 -0700 (PDT)
In-Reply-To: <47F1755F.9000303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello,

Mark Lord wrote:
> static int mv_prereset(struct ata_link *link, unsigned long deadline)
> {
> -    mv_stop_edma(link->ap);
> +    if (mv_stop_edma(link->ap))
> +        link->eh_context.i.action |= ATA_EH_HARDRESET;
> +    return ata_std_prereset(link, deadline);
> +}

libata#upstream now defaults to hardreset.  softreset is used only as 
followup-SRST in case hardreset can't classify or PMP is supported, so 
there's no reason to add reset promotion logic anymore.

> +    /* FIXME:
> +     * Except for the outer do-while construct below, this function
> +     * is an exact clone of sata_std_hardreset() from libata-core.c.
> +     *
> +     * Once this driver is stable, we should re-org libata so we can share
> +     * more of that code, rather than duplicating so much of it here
> +     * and in other drivers.
> +     */

After modularize patchsets, sata_link_hardreset() does all the chores 
needed around hardreset and sata_mv should be able to just build a loop 
around it.

Thanks.

-- 
tejun
