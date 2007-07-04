From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/15] ide: ide_find_best_pio_mode() fixes
Date: Wed, 04 Jul 2007 20:19:44 +0400
Message-ID: <468BC8A0.1080200@ru.mvista.com>
References: <200706302104.42299.bzolnier@gmail.com> <468917D2.6010907@ru.mvista.com> <200707022005.01655.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32346 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756682AbXGDQRs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 12:17:48 -0400
In-Reply-To: <200707022005.01655.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: ide_find_best_pio_mode() fixes (take 2)

> * Check IORDY bit for PIO modes > 2.

> * Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
>   severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.

> v2:
> * Fix PIO number being returned incorrectly instead of PIO mode
>   (Noticed by Sergei).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
