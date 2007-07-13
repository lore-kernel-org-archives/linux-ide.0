From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] amd74xx/via82cxxx: use ide_tune_dma()
Date: Fri, 13 Jul 2007 20:57:08 +0400
Message-ID: <4697AEE4.9060001@ru.mvista.com>
References: <200707110204.42227.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45082 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752262AbXGMQzG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 12:55:06 -0400
In-Reply-To: <200707110204.42227.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use ide_tune_dma() in amd74xx/via82cxxx driver, this fixes following bugs:
>   - DMA capability bit not being checked on the device
>   - DMA blacklist not being checked
>   - DMA mode being programmed even if drive->autodma == 0
>     (thus possibly destroying PIO timings)

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
