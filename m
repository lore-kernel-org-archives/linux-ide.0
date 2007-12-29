From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] icside: use hwif->dev
Date: Sat, 29 Dec 2007 16:52:17 +0300
Message-ID: <47765111.9030303@ru.mvista.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191245.1357.38374.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12023 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752984AbXL2Nvu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Dec 2007 08:51:50 -0500
In-Reply-To: <20071227191245.1357.38374.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Bartlomiej Zolnierkiewicz wrote:

> * Setup hwif->dev in icside_setup().

> * Use hwif->dev instead of state->dev in icside_build_sglist(),
>   icside_dma_end(), icside_dma_start() and icside_dma_setup().

> * Remove no longer needed 'dev' field from struct icside_state.

> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
