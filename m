From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] it8213: PIO fixes (take 2)
Date: Sat, 14 Jul 2007 20:47:17 +0400
Message-ID: <4698FE15.7010407@ru.mvista.com>
References: <200707132303.09330.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50509 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755348AbXGNQpM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 12:45:12 -0400
In-Reply-To: <200707132303.09330.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Rename it8213_tuneproc() to it8213_tune_pio() and add it8213_tuneproc()
>   wrapper.  Move finding of the best PIO mode to the new wrapper.

> * Add setting of transfer mode on the device to it8213_tuneproc().

> * Don't call it8213_dma_2_pio() for PIO modes in it8213_tune_chipset().

> * Use it8213_tuneproc() in it8213_config_drive_for_dma().

> v2:
> * Remove PIO modes from it8213_dma_2_pio(), they are no longer needed there
>   (Noticed by Sergei)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
