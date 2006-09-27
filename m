From: Tejun Heo <htejun@gmail.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Wed, 27 Sep 2006 10:36:05 +0900
Message-ID: <4519D585.5010604@gmail.com>
References: <KMS--2047072133-2724@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:9643 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932227AbWI0BgK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 21:36:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so36681pyg
        for <linux-ide@vger.kernel.org>; Tue, 26 Sep 2006 18:36:10 -0700 (PDT)
In-Reply-To: <KMS--2047072133-2724@mail.norwalkdist.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Trent George <trent@norwalkdist.com>
Cc: linux-ide@vger.kernel.org

Hello, Trent.

Trent George wrote:
> Hi Tejun,
> 
> Well after 2 days and nights of trying to hack into the driver to figure what is my problem....
> 
> I have a fix for me, and an explanation
> The problem seemed related to a pioneer drive and bridgeboard

I have one px716-sa (embedded bridge board), several PATA odds and an 
external simg bridge board.  All of them work okay with the current code.

> I modified sata_sil24.c with the following addition
> 
> in the sil24_do_softreset funtion:
> 
> +	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
> 
> 	/* put the port into known state */
> 	if (sil24_init_port(ap)) {
> 		reason ="port not ready";
> 		goto err;
> 	}
> 
> +	ata_wait_register(port + PORT_CTRL_STAT, 0x1f0000,
> +		x1f0000, 10, 2000);
> +	
> 	/* do SRST */
> 	ata_tf_init(link->device, &tf);	/* doesn't really matter */
> 
> this will wait until the "active slot" of the "port status" field changes from the port mulitpler pmp id of 0x1f (still executing previous command)
> it seemed there was a delay from 12 to 84 jiffies for this to clear.
> everything works perfect for me now.

That's interesting.  I guess that's from sil24_clear_pmp().  Maybe that 
function needs to wait for active slot to change after clearing each 
port's error condition.  Hmm.. wasn't in the spec though.

> sorry I dont know how to post a patch using the correct method.
> and I know this is not the "correct" fix, but it is the essence of what needs to be done. This will probablly fix the issue of mixing ATAPI and ATA devices, slow devices or bridgeboards causing reset cycling, and using or not the pmp port 0

So, you're saying that this is the same problem which causes reset 
failures if port 0 is unoccupied?  That's great.  Thanks a lot for 
tracking this problem down.

> ps: I used this ugly code to see what was happening:
> ------------
> 	tmp0 = ata_wait_register(port + PORT_CTRL_STAT,	PORT_CS_RDY,
> 		0, 10, 10);
> 	tmp1 = jiffies;
> 	tmp = ata_wait_register(port + PORT_CTRL_STAT,	0x1f0000,
> 		0x1f0000, 10, 1000);
> 	ata_link_printk(link, KERN_ERR, "wait for ready on pmp %d %x %x %d\n ", pmp, tmp0, tmp, jiffies-tmp1);
> --------------

Pretty enough.  :-)  I'll investigate into sil24_clear_pmp() and try to 
merge your fix.

Thanks.

-- 
tejun
