From: Tejun Heo <htejun@gmail.com>
Subject: Re: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
 SATA multiplier
Date: Wed, 01 Dec 2010 10:45:25 +0100
Message-ID: <4CF61935.2080501@gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com> <4CF50574.6000706@gmail.com> <AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com> <4CF55549.4080000@gmail.com> <AANLkTinyJdTYXgpfvmw8vRBEFOc+SdCKe9hBZbGk1oLd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39614 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab0LAJpG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Dec 2010 04:45:06 -0500
Received: by bwz15 with SMTP id 15so5924727bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 01 Dec 2010 01:45:04 -0800 (PST)
In-Reply-To: <AANLkTinyJdTYXgpfvmw8vRBEFOc+SdCKe9hBZbGk1oLd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On 12/01/2010 06:53 AM, Lin Mac wrote:
> While using multiplier with CONFIG_SATA_PMP enabled, or using disks directly
> without CONFIG_SATA_PMP have no issue.
> 
> It is because sata_srst_pmp always return SATA_PMP_CTRL_PORT(15),
> which casued ahci_do_softreset with pmp 15, which is not needed for
> disks connected directly.

SRST w/ PMP==15 is the standard defined way to probe devices for PMP
capable controllers.

> With SPMH3726-P rev:2.1.2, ata_dev_classify would report ATA_DEV_UNKNOWN on
> ahci_hardreset. While with a Segate Barracuda 1TB SATA HD, it is ATA_DEV_ATA.
> Therefore, the pmp returned by sata_srst_pmp should depends on the class
> reported by ahci_hardreset.

IIRC, PMP should return the signature of the first device after
hardreset.  At any rate, the standard sanctioned way to probe is SRST
w/ PMP==15.

> This patch does 2 things:
> 1. ata_eh_reset calls ata_do_reset upon SRST without clearing classes, to be
>    used by sata_srst_pmp to decide pmp.
> 2. sata_srst_pmp returns SATA_PMP_CTRL_PORT only when class is ATA_DEV_PMP or
>    ATA_DEV_UNKNOWN

So, no, this isn't acceptable.  You're making the behavior deviate
from the standard for all controllers and devices to work around a
faulty, rather obscure controller.  If you want to work around, please
implement a workaround which is specific to the controller in
question.

Thanks.

-- 
tejun
