From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/12] piix/slc90e66: fix PIO1 handling in ->speedproc
 method
Date: Mon, 09 Jul 2007 21:03:05 +0400
Message-ID: <46926A49.3020802@ru.mvista.com>
References: <200707081536.54841.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:4674 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757448AbXGIRBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 13:01:05 -0400
In-Reply-To: <200707081536.54841.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
>   {piix,slc90e66}_tune_chipset().

    XFER_PIO_* switch cases might have been be deleted from 
{piix,slc90e66}_dma_2_pio() then...

> * Add PIO1 handling to {piix,slc90e66}_tune_chipset().

> * Bump driver version.  

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
