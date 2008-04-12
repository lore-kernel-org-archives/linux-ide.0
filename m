From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/5] ide: remove ->dma_prdtable field from ide_hwif_t
Date: Sat, 12 Apr 2008 22:56:30 +0400
Message-ID: <480105DE.6040904@ru.mvista.com>
References: <200804122105.42636.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45197 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752906AbYDLS5M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 14:57:12 -0400
In-Reply-To: <200804122105.42636.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use 'hwif->dma_base + {4,8}' instead of hwif->dma_prdtable in
>   {ide,scc}_dma_setup().

> * Remove no longer needed ->dma_prdtable field from ide_hwif_t.

> While at it:

> * Use ATA_DMA_TABLE_OFS define.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

