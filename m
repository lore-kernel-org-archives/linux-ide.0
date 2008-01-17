From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Thu, 17 Jan 2008 21:57:02 +0300
Message-ID: <478FA4FE.4010106@ru.mvista.com>
References: <200801172150.57059.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56681 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755178AbYAQS4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jan 2008 13:56:10 -0500
In-Reply-To: <200801172150.57059.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Anton Salnikov wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

> I had to export two functions (ide_dma_exec_cmd and __ide_dma_test_irq) from 
> driver/ide/ide-dma.c to get rid of copying them.

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
