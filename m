From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: remove stale ide.h "configuration options"
Date: Sat, 27 Oct 2007 20:50:55 +0400
Message-ID: <47236C6F.8010203@ru.mvista.com>
References: <200710262329.17605.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:2354 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754254AbXJ0Qur (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 12:50:47 -0400
In-Reply-To: <200710262329.17605.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove stale ide.h "configuration options":

> * INITIAL_MULT_COUNT - always defined to 0

> * SUPPORT_SLOW_DATA_PORTS - unused

> * OK_TO_RESET_CONTROLLER - always defined to 0

> * DISABLE_IRQ_NOSYNC - always defined to 0

> Leave SUPPORT_VLB_SYNC (defined to 0 for CRIS and FRV, otherwise to 1)
> for now but disallow overriding it by <asm/ide.h>.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
