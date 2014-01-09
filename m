From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 0/3] ata: ahci_platform: Add PHY support and OMAP support
Date: Thu, 09 Jan 2014 12:33:54 +0100
Message-ID: <1389284177.iKaZgY0Ov4@amdc1032>
References: <1389264962-22858-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27288 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAILeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 06:34:15 -0500
In-reply-to: <1389264962-22858-1-git-send-email-rogerq@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, kishon@ti.com, hdegoede@redhat.com, arnd@arndb.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


Hi,

On Thursday, January 09, 2014 04:25:59 PM Roger Quadros wrote:
> Hi,
> 
> Some platforms have a PHY hooked up to the SATA controller.
> The PHY needs to be initialized and powered up for SATA to work.
> We do that using the Generic PHY framework in PATCH 2.
> 
> In order to support SATA on the OMAP platforms we need to runtime
> resume the device before use. PATCH 3 takes care of that.
> 
> PATCH 1 just updates the compatible list in the DT binding document.
> 
> Changelog:
> v4:
> - Tackle error conditions while using PHY framework APIs.
> 
> v3:
> - Addressed review comments and rebased on 3.13-rc7
> - DT binding update moved to new patch.
> 
> v2:
> - got rid of Texas Instruments SATA wrapper driver
> - adressed review comments

Thanks for fixing it.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

