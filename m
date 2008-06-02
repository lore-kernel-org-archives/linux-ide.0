From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 02/21] ide: remove unused XFER_UDMA_SLOW
Date: Mon, 02 Jun 2008 15:43:09 +0400
Message-ID: <4843DCCD.6080600@ru.mvista.com>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain> <20080528214002.16327.28489.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38561 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755936AbYFBLnP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 07:43:15 -0400
In-Reply-To: <20080528214002.16327.28489.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove unused XFER_UDMA_SLOW from ide_timing[].

> While at it:

> - fix re-defining XFER_PIO_5 (no need to define it in ide-timing.h as
>   it is defined in <linux/ata.h> which is included by <linux/hdreg.h>)

> - fix whitespace damage

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
