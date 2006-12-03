From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: always use polling IDENTIFY
Date: Sun, 03 Dec 2006 06:14:18 -0500
Message-ID: <4572B18A.8010206@pobox.com>
References: <20061203103032.GE11250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54219 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S936687AbWLCLOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 06:14:23 -0500
In-Reply-To: <20061203103032.GE11250@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata switched to IRQ-driven IDENTIFY when IRQ-driven PIO was
> introduced.  This has caused a lot of problems including device
> misdetection and phantom device.
> 
> ATA_FLAG_DETECT_POLLING was added recently to selectively use polling
> IDENTIFY on problemetic drivers but many controllers and devices are
> affected by this problem and trying to adding ATA_FLAG_DETECT_POLLING
> for each such case is diffcult and not very rewarding.
> 
> This patch makes libata always use polling IDENTIFY.  This is
> consistent with libata's original behavior and drivers/ide's behavior.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, but does not apply to #upstream[1], which includes the tj-upstream 
that I pulled.

	Jeff



[1] 8e16f941226f15622fbbc416a1f3d8705001a191
