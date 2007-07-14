From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported
 modes
Date: Sat, 14 Jul 2007 21:42:05 +0400
Message-ID: <46990AED.50204@ru.mvista.com>
References: <200707110200.37607.bzolnier@gmail.com> <200707112321.41597.bzolnier@gmail.com> <46967FA8.4090406@ru.mvista.com> <200707132302.04065.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50669 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757878AbXGNRkA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 13:40:00 -0400
In-Reply-To: <200707132302.04065.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] icside: fix ->speedproc to return on unsupported modes (take 3)

> * All other implementations of ->speedproc return zero on success
>   and non-zero on failure.  Currently it doesn't matter for icside host
>   driver and isn't a bug per se since:

>   - ide_set_xfer_rate() return value is ignored by all IDE core users

>   - icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

>   but sooner or later we will need to fix anyway - so lets do it now.

> * icside_set_speed() happily accepts unsupported transfer modes which
>   results in drive->drive_data being set to the maximum value (480)
>   and drive->current_speed being set to the unsupported transfer mode.

>   Fix it.

> v2:
> * The initial version of the patch was broken because it didn't take into
>   the account (the different from usual) return values of icside_set_speed()
>   (Noticed by Russell).

> v3:
> * Remove no longer needed initialization/checking of cycle_time
>   (Noticed by Sergei).

> * No need to set drive->drive_data if DMA is not going to be used
>   (Noticed by Sergei).

> * Remove incorrect setting of drive->current_speed
>   (Noticed by Sergei).

> * Move ide_config_drive_speed() at the end of icside_set_speed().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
