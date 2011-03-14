From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC PATCH 1/2] AHCI Add the AHCI SATA feature on MX53 platforms
Date: Mon, 14 Mar 2011 10:50:46 -0400
Message-ID: <4D7E2B46.6010605@pobox.com>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64777 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1CNOuv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 10:50:51 -0400
Received: by vxi39 with SMTP id 39so4378989vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 07:50:50 -0700 (PDT)
In-Reply-To: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On 03/14/2011 05:55 AM, Richard Zhu wrote:
> Signed-off-by: Richard Zhu<Hong-Xing.Zhu@freescale.com>
> ---
>   arch/arm/mach-mx5/clock-mx51-mx53.c             |   11 +++++
>   arch/arm/mach-mx5/devices-imx53.h               |    4 ++
>   arch/arm/plat-mxc/devices/Kconfig               |    4 ++
>   arch/arm/plat-mxc/devices/Makefile              |    1 +
>   arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   55 +++++++++++++++++++++++
>   arch/arm/plat-mxc/include/mach/ahci_sata.h      |   51 +++++++++++++++++++++
>   arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++++
>   7 files changed, 136 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>   create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

Acked-by: Jeff Garzik <jgarzik@redhat.com>


