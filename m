From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] piix/slc90e66: fix PIO1 handling in ->speedproc method
 (take 2)
Date: Sat, 14 Jul 2007 20:51:50 +0400
Message-ID: <4698FF26.6020500@ru.mvista.com>
References: <200707132303.39408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50535 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759483AbXGNQtp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 12:49:45 -0400
In-Reply-To: <200707132303.39408.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
>   {piix,slc90e66}_tune_chipset().

> * Add PIO1 handling to {piix,slc90e66}_tune_chipset().

> * Bump driver version.  

> v2:
> * Remove PIO modes from {piix,slc90e66}_dma_2_pio(), they are no longer needed
>   there (Noticed by Sergei)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
