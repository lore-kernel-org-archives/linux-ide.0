From: Brett Russ <icycle@gmail.com>
Subject: Re: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Fri, 01 Apr 2005 00:52:52 -0500
Message-ID: <424CE1B4.10107@gmail.com>
References: <424CE03C.7020903@tw.ibm.com>
Reply-To: bruss@alum.wpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:25728 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262644AbVDAFxH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 00:53:07 -0500
In-Reply-To: <424CE03C.7020903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> -    printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
> -           ap->id, drv_stat);
> +    DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);

You'd probably want this to stay a printk so it persists when ATA_DEBUG 
is off, right?

BR
