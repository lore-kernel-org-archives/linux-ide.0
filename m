From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: always use polling IDENTIFY
Date: Sun, 3 Dec 2006 12:56:03 +0000
Message-ID: <20061203125603.493ebde6@localhost.localdomain>
References: <20061203103032.GE11250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32489 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757659AbWLCMtA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 07:49:00 -0500
In-Reply-To: <20061203103032.GE11250@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sun, 3 Dec 2006 19:30:32 +0900
Tejun Heo <htejun@gmail.com> wrote:

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

Acked-by: Alan Cox <alan@redhat.com>

One possibility however would be to invert the flag we have now so we can
try turning -on- IRQ polling on some devices in future and maybe figure
it out that way around ?

Alan
