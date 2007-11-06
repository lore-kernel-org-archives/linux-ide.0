From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] sl82c105: program DMA/PIO timings in ->dma_start/->ide_dma_end
Date: Tue, 06 Nov 2007 15:21:59 +0300
Message-ID: <47305C67.7080502@ru.mvista.com>
References: <200711060026.51049.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30988 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755269AbXKFMVp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 07:21:45 -0500
In-Reply-To: <200711060026.51049.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Program DMA timings in sl82c105_dma_start() (->dma_start method)
>   before starting DMA transfer.

> * Add sl82c105_dma_end() (->ide_dma_end method) to switch back to
>   PIO timings when DMA transfer is complete.

> * In sl82c105_set_pio_mode() program timings regardless of ->using_dma
>   setting and in sl82c105_set_dma_mode() only cache the new timings.

> * Remove no longer needed sl82c105_{ide_dma_on,off_quietly}().

    Well, the right fix would have been to merge PIO/DMA timings -- but I
must admit that I have nearly forgotten about my existing but unfinished
version by now. :-|

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

