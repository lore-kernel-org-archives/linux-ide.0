From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/12] triflex: add missing ->dma_base check
Date: Sun, 29 Jul 2007 23:06:36 +0400
Message-ID: <46ACE53C.8030704@ru.mvista.com>
References: <200707291953.32443.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57312 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760093AbXG2TEg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 15:04:36 -0400
In-Reply-To: <200707291953.32443.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> If ->dma_base is not set (== PCI BAR4 cannot be reserved) then DMA hooks
> shouldn't be initialized or bad things will happen.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
