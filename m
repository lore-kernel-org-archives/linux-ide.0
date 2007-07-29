From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/12] pdc202xx_old: add missing ->dma_base check
Date: Sun, 29 Jul 2007 23:09:02 +0400
Message-ID: <46ACE5CE.6040606@ru.mvista.com>
References: <200707291952.32929.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57323 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762742AbXG2THB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 15:07:01 -0400
In-Reply-To: <200707291952.32929.bzolnier@gmail.com>
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
