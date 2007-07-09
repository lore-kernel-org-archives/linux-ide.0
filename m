From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/12] it8213: PIO fixes
Date: Mon, 09 Jul 2007 21:05:37 +0400
Message-ID: <46926AE1.8020004@ru.mvista.com>
References: <200707081535.12938.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:4711 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754419AbXGIRDf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 13:03:35 -0400
In-Reply-To: <200707081535.12938.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Rename it8213_tuneproc() to it8213_tune_pio() and add it8213_tuneproc()
>   wrapper.  Move finding of the best PIO mode to the new wrapper.

> * Add setting of transfer mode on the device to it8213_tuneproc().

> * Don't call it8213_dma_2_pio() for PIO modes in it8213_tune_chipset().

   Again, XFER_PIO_* switch cases might have been be deleted from 
it8213_dma_2_pio() then... Though the idea was to part with this function 
completely -- to be done yet...

> * Use it8213_tuneproc() in it8213_config_drive_for_dma().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

