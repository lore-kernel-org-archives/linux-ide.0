From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] it821x: fix incorrect SWDMA mask
Date: Tue, 03 Jul 2007 18:09:11 +0400
Message-ID: <468A5887.3010609@ru.mvista.com>
References: <200707030145.59287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23911 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755163AbXGCOHa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 10:07:30 -0400
In-Reply-To: <200707030145.59287.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> SWDMA modes are unsupported by it821x.  Attempts to tune SWDMA modes always
> fail (due to sanity check in ->speedproc) and result in PIO being tuned.

> * Fix incorrect SWDMA mask so core code won't try these modes and will just
>   tune PIO if no other DMA modes are available.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
