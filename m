From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v3] PXA DMA-capable PATA driver
Date: Mon, 17 May 2010 23:56:38 -0400
Message-ID: <4BF20FF6.4020506@garzik.org>
References: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64128 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0ERD4l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:56:41 -0400
Received: by gwaa20 with SMTP id a20so918848gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:56:40 -0700 (PDT)
In-Reply-To: <1274137768-27707-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, robert.jarzmik@free.fr

On 05/17/2010 07:09 PM, Marek Vasut wrote:
> This patch adds a driver for a harddrive attached to PXA address and data bus.
> Unlike pata_platform, this driver allows usage of PXA DMA controller, making the
> transmission speed 3x higher.
>
> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> ---
>   arch/arm/mach-pxa/include/mach/pata_pxa.h |   33 +++
>   drivers/ata/Kconfig                       |   11 +
>   drivers/ata/Makefile                      |    1 +
>   drivers/ata/pata_pxa.c                    |  404 +++++++++++++++++++++++++++++
>   4 files changed, 449 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-pxa/include/mach/pata_pxa.h
>   create mode 100644 drivers/ata/pata_pxa.c

Acked-by: Jeff Garzik <jgarzik@redhat.com>

There are a few minor issues remaining, but we can take care of them 
post-merge.  I presume you'll send this via arm tree.


