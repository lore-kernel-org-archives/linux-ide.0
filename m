From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/13] cy82c693: correct DMA modes clipping
Date: Wed, 14 Nov 2007 17:58:44 +0300
Message-ID: <473B0D24.50907@ru.mvista.com>
References: <200711130001.33628.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:46527 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752005AbXKNO6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 09:58:33 -0500
In-Reply-To: <200711130001.33628.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Mask device DMA masks by ATA_{S,M}WDMA2 in cy82c693_ide_dma_on().

> * Remove clipping of DMA modes by id->tDMA in cy82c693_dma_enable():
>   - id->tDMA may not be defined on newer devices
>   - id->vendor6/id->tDMA word is in LE endianness
>     (cy82c693 seems to be Alpha specific though)

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

