From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/8] ide: make ide_dma_lost_irq() available also for CONFIG_BLK_DEV_IDEDMA_SFF=n
Date: Wed, 03 Sep 2008 01:42:17 +0400
Message-ID: <48BDB339.2050403@ru.mvista.com>
References: <20080902194711.14564.63625.sendpatchset@localhost.localdomain> <20080902194718.14564.27048.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16247 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751646AbYIBVmX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Sep 2008 17:42:23 -0400
In-Reply-To: <20080902194718.14564.27048.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Make ide_dma_lost_irq() available also for CONFIG_BLK_DEV_IDEDMA_SFF=n
> and convert {ics,au1xxx-}ide.c to use it.
>
> While at it:
> - use EXPORT_SYMBOL_GPL() to match the rest of SFF DMA functions
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


