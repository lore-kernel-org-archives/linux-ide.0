From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/7] ide: remove CONFIG_BLK_DEV_IDEDMA_FORCED
Date: Sun, 19 Aug 2007 17:32:53 +0400
Message-ID: <46C84685.4060501@ru.mvista.com>
References: <200708182048.04009.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61158 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751845AbXHSNaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 09:30:30 -0400
In-Reply-To: <200708182048.04009.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> This code doesn't use pci_assign_resource() and ide_get_or_set_dma_base() uses
> pci_resource_start() to get DMA base address so it has no chance of working.
> Moreover this belongs to PCI quirks (in case somebody would like to fix it).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
