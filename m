From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 19/21] ide: move ide_pio_cycle_time() to ide-timings.c
Date: Mon, 02 Jun 2008 15:49:19 +0400
Message-ID: <4843DE3F.7040001@ru.mvista.com>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain> <20080528214320.16327.69738.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38648 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752553AbYFBLtZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 07:49:25 -0400
In-Reply-To: <20080528214320.16327.69738.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> All ide_pio_cycle_time() users already select CONFIG_IDE_TIMINGS
> so move the function from ide-lib.c to ide-timings.c.

> While at it:

> - convert ide_pio_cycle_time() to use ide_timing_find_mode()

> - cleanup ide_pio_cycle_time() a bit

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
