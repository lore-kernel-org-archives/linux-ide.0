From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/3] ata: ahci_platform: Add PHY support and OMAP support
Date: Thu, 9 Jan 2014 12:05:24 +0100
Message-ID: <201401091205.24818.arnd@arndb.de>
References: <1389264962-22858-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56849 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaAILF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 06:05:29 -0500
In-Reply-To: <1389264962-22858-1-git-send-email-rogerq@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tj@kernel.org, sergei.shtylyov@cogentembedded.com, kishon@ti.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thursday 09 January 2014, Roger Quadros wrote:
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
