From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/7] drivers/ata/pata_radisys.c: cleanup kernel-doc
Date: Tue, 25 Nov 2008 11:39:11 -0500
Message-ID: <492C2A2F.9070309@garzik.org>
References: <491feb5b.08486e0a.075a.4c48@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40320 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbYKYQjQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 11:39:16 -0500
In-Reply-To: <491feb5b.08486e0a.075a.4c48@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Qinghuang Feng <qhfeng.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

Qinghuang Feng wrote:
> No argument named @isich in radisys_set_dmamode,
> remove it.
> 
> Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
> ---
> diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
> index 0b0aa45..695d44a 100644
> --- a/drivers/ata/pata_radisys.c
> +++ b/drivers/ata/pata_radisys.c
> @@ -81,7 +81,6 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
>   *	radisys_set_dmamode - Initialize host controller PATA DMA timings
>   *	@ap: Port whose timings we are configuring
>   *	@adev: Device to program
> - *	@isich: True if the device is an ICH and has IOCFG registers
>   *
>   *	Set MWDMA mode for device, in host controller PCI config space.
>   *

applied 1-7 to #upstream, after combining into a single patch.  I felt a 
single changeset was more appropriate.


