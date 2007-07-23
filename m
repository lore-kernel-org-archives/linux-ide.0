From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/11] ide: add __ide_wait_stat() helper
Date: Mon, 23 Jul 2007 17:18:15 +0400
Message-ID: <46A4AA97.9060702@ru.mvista.com>
References: <200707222031.30499.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:2014 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755394AbXGWNQN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 09:16:13 -0400
In-Reply-To: <200707222031.30499.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Split off checking of the status register from ide_wait_stat() to
>   __ide_wait_stat() helper.

> * Use the new helper in ide_config_drive_speed().  The only change in the
>   functionality is that the function now fails if after 20 sec (WAIT_CMD)
>   device is still busy (BUSY_STAT bit is set) while previously instead of
>   failing the function continued with checking for the correct device status
>   (which would give the device additional 10 usec to clear BUSY_STAT bit).

> * Remove stale comment for ide_config_drive_speed().

> * Remove duplicate comment for ide_wait_stat() from <linux/ide.h>.

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
