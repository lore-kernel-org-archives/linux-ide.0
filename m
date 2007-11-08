From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 17/18] ide: cleanup ide_set_dma()
Date: Thu, 08 Nov 2007 16:36:51 +0300
Message-ID: <473310F3.4040200@ru.mvista.com>
References: <200711050033.58423.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53907 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753214AbXKHNgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 08:36:39 -0500
In-Reply-To: <200711050033.58423.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * ->dma_off_quietly is always called before ide_set_dma()
>   so the call can be moved inside ide_set_dma().

> * ide_dma_check() doesn't touch hardware so ->dma_off_quietly
>   call for 'rc == -1' case is redundant, remove it.

> * '0' and '-1' are the only values returned by ide_dma_check()
>   so remove dead code for other cases.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
