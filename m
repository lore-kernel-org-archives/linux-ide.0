From: Tejun Heo <htejun@gmail.com>
Subject: Re: PMP device port link speed issues
Date: Tue, 30 Oct 2007 08:20:56 +0900
Message-ID: <47266AD8.4060505@gmail.com>
References: <2A6F278C5B66C4459AF4013E77A40CD301003529@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:2523 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbXJ2XVK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 19:21:10 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1296324nze
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 16:21:09 -0700 (PDT)
In-Reply-To: <2A6F278C5B66C4459AF4013E77A40CD301003529@zin33exm20.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Kalra Ashish-B00888 wrote:
> Hello Tejun,
> 
> This patch will surely fix my problem, but won't it be better to set
> each PMP device port link speed directly to
> the host<->PMP link speed, during SATA PMP device configuration in
> sata_pmp_attach(), instead of calling 
> sata_link_init_spd() for each link. 
> 
> The PMP chip should be responsible for matching link speed difference,
> but probably there could be issues with
> certain PMP chips, as it looks like in our case, where NCQ hangs are
> probably caused due to link speed difference.
> It should be simpler to handle it in S/W, by limiting PMP device port
> link speeds to host<->PMP link speed.

Yeah, I agree.  There's nearly nothing to be gained by driving
downstream PHYs faster than the upstream PHY.  I'll submit a patch to
limit downstream port speed by upstream speed.

Thanks.

-- 
tejun
