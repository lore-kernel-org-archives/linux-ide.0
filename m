From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_nv: cleanup CPB and APRD initialization
Date: Mon, 26 Feb 2007 18:26:34 -0500
Message-ID: <45E36CAA.2050809@garzik.org>
References: <200702262259.l1QMxKug009433@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44139 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbXBZX0h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Feb 2007 18:26:37 -0500
In-Reply-To: <200702262259.l1QMxKug009433@hera.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockr@shaw.ca
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=41949ed5c11a9d6e7af1afd62957d8d1988c803e
> Commit:     41949ed5c11a9d6e7af1afd62957d8d1988c803e
> Parent:     08af7414786a3f35b686f68ada3de0b202c03d8c
> Author:     Robert Hancock <hancockr@shaw.ca>
> AuthorDate: Mon Feb 19 19:02:27 2007 -0600
> Committer:  Jeff Garzik <jeff@garzik.org>
> CommitDate: Wed Feb 21 04:58:19 2007 -0500
> 
>     sata_nv: cleanup CPB and APRD initialization
>     
>     Clean up the initialization of the CPB and APRD structures so that we
>     strictly follow the rules for ordering of writes to the CPB flags and
>     response flags, and prevent duplicate initialization.
>     
>     Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> ---

> @@ -1199,6 +1196,8 @@ static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
>  	}
>  	if (idx > 5)
>  		cpb->next_aprd = cpu_to_le64(((u64)(pp->aprd_dma + NV_ADMA_SGTBL_SZ * qc->tag)));
> +	else
> +		cpb->next_aprd = cpu_to_le64(0);

Note, there is no need to convert a zero to little endian.  There are no 
bits to swap :)

	Jeff


