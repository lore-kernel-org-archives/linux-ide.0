From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci.c: walkaround for SB600 SATA internal error issue
Date: Tue, 27 Mar 2007 19:48:57 +0900
Message-ID: <4608F699.9030102@gmail.com>
References: <5767b9100703270333k71361b89n756281124fd78c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:27669 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbXC0KtE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 06:49:04 -0400
Received: by ik-out-1112.google.com with SMTP id c21so2033029ika
        for <linux-ide@vger.kernel.org>; Tue, 27 Mar 2007 03:49:03 -0700 (PDT)
In-Reply-To: <5767b9100703270333k71361b89n756281124fd78c80@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Conke Hu <conke.hu@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Conke Hu wrote:
>   There is a HW issue in ATI SB600 SATA that PxSERR.E should not be
> set on some conditions, for example, when there is no media in SATA
> CD/DVD drive or media is not ready, AHCI controller fails to execute
> ATAPI commands and reports PORT_IRQ_TF_ERR, but ATI SB600 SATA
> controller sets PxSERR.E at the
> same time, which is not necessary.
>    This patch is just to ignore the INTERNAL ERROR in such case.
> Without this patch, ahci error handler will report many errors as
> below:
>    ----------- cut from dmesg -----------
> ata9: soft resetting port
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata9.00: configured for UDMA/33
> ata9: EH complete
> ata9.00: exception Emask 0x40 SAct 0x0 SErr 0x800 action 0x2
> ata9.00: (irq_stat 0x40000001)
> ata9.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>        res 51/24:03:00:00:20/00:00:00:00:00/a0 Emask 0x40 (internal error)
> ata9: soft resetting port
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata9.00: configured for UDMA/33
> ata9: EH complete
> ata9.00: exception Emask 0x40 SAct 0x0 SErr 0x800 action 0x2
> ata9.00: (irq_stat 0x40000001)
> ata9.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
>        res 51/24:03:00:00:00/00:00:00:00:00/a0 Emask 0x40 (internal error)
>    -------- end cut ---------
> 
> Signed-off-by: Conke Hu <conke.hu@amd.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
