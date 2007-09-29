From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] aec62xx: remove aec62xx_dma_lost_irq()
Date: Sat, 29 Sep 2007 23:20:37 +0400
Message-ID: <46FEA585.5080205@ru.mvista.com>
References: <200709172208.08968.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56659 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbXI2TUz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 15:20:55 -0400
In-Reply-To: <200709172208.08968.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Remove aec62xx_dma_lost_irq() (generic ide_dma_lost_irq() will be used now).

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
