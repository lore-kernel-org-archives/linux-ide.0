From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] cs5520: don't enable VDMA in ->speedproc
Date: Sat, 14 Jul 2007 21:10:19 +0400
Message-ID: <4699037B.4080403@ru.mvista.com>
References: <200707132311.19938.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50586 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754667AbXGNRIO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 13:08:14 -0400
In-Reply-To: <200707132311.19938.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> There is no need to do it in cs5520_tune_chipset() (->speedproc method)
> since it is correctly handled by cs5520_dma_on() (->ide_dma_on method).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
