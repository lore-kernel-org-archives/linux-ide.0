From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 18/18] ide: remove redundant DMA blacklist check from
 __ide_dma_on()
Date: Tue, 06 Nov 2007 15:01:29 +0300
Message-ID: <47305799.2070306@ru.mvista.com>
References: <200711050034.44342.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30817 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754485AbXKFMBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 07:01:16 -0500
In-Reply-To: <200711050034.44342.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ->ide_dma_on method is called only after successful ide_dma_check() call
> (ide_dma_check()->ide_tune_dma() checks DMA blacklist) or if drive->using_dma
> has been previously enabled for a given device (->ide_dma_on is the only place
> which sets drive->using_dma to '1').

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
