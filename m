From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/18] sis5513: factor out UDMA programming code
Date: Fri, 09 Nov 2007 17:12:18 +0300
Message-ID: <47346AC2.3090704@ru.mvista.com>
References: <200711050026.49990.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1347 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758302AbXKIOMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 09:12:05 -0500
In-Reply-To: <200711050026.49990.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Factor out UDMA programming code from sis_set_dma_mode() to per
>   chipset family helpers: sis_{ata33,ata133}_program_udma_timings().

> * Add sis_program_udma_timings() helper.

> * Remove unneeded casts to 'unsigned long'.

> * Minor cleanups.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
