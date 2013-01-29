From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 0/2] Adding SATA PHY framework and PHY controller driver
Date: Tue, 29 Jan 2013 20:18:57 +0100
Message-ID: <27192849.OiIKBt794p@flatron>
References: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:44355 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab3A2TTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2013 14:19:03 -0500
In-Reply-To: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org

Hi,

On Tuesday 29 of January 2013 20:49:16 Vasanth Ananthan wrote:
> Adding SATA PHY framework. The framework acts as an interface
> between the SATA controller and the PHY controller.
> 
> The framework can be used by any platform with device tree support.
> It primarily serves to de-couple the SATA controller driver and the
> PHY controller driver.
> 
> Vasanth Ananthan (2):
>   driver: ata: SATA PHY framework
>   driver: ata: add new Exynos5250 SATA PHY controller driver
> 
>  arch/arm/mach-exynos/include/mach/regs-pmu.h  |    3 +
>  arch/arm/mach-exynos/include/mach/regs-sata.h |   29 +++
>  drivers/ata/Kconfig                           |   10 +
>  drivers/ata/Makefile                          |    1 +
>  drivers/ata/sata_exynos_phy.c                 |  265
> +++++++++++++++++++++++++ drivers/ata/sata_phy.c                       
> |  145 ++++++++++++++ drivers/ata/sata_phy.h                        |  
> 29 +++
>  7 files changed, 482 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h
>  create mode 100644 drivers/ata/sata_exynos_phy.c
>  create mode 100644 drivers/ata/sata_phy.c
>  create mode 100644 drivers/ata/sata_phy.h

It seems like you haven't addressed any of the comments received last time 
you posted this series...

Best regards,
Tomasz

