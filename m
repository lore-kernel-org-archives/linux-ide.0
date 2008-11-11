From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream] libata: improve timeout handling for EH
 commands
Date: Tue, 11 Nov 2008 11:27:08 +0900
Message-ID: <4918ED7C.1000605@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>	 <48458809.1030207@garzik.org> <484621D7.1040607@gmail.com> <c70ff3ad0811100832g39b838fepd214cdc16ee129f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:15917 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYKKC1P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 21:27:15 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1717054tic.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 18:27:13 -0800 (PST)
In-Reply-To: <c70ff3ad0811100832g39b838fepd214cdc16ee129f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca

saeed bishara wrote:
> Hi,
>        This patch is guilty for big delay when I boot my system with
> marvell soc sata with 4140 pmp (without disks). I added print for the
> deadline and now variables in the ata_eh_reset.
> here is the output:
> ata2: SATA max UDMA/133 irq 29
>  sleep deadline -35455  now -29955
>  sleep done
> ata1: SATA link down (SStatus 0 SControl 300)
>  sleep deadline -35419  now -29919
>  sleep done
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.15: Port Multiplier 1.1, 0x11ab:0x4140 r193, 5 ports, feat 0x1/0x1f
>  sleep deadline 500  now -29867
> 
> it seems that in may case the ehc->last_reset was not initialized.

Yeap, it didn't initialize last_reset for new pmp links.  Patch to fix
already has been posted and pending for upstream and -stable.

Thanks.

-- 
tejun
