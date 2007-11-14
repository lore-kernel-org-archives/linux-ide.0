From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 9/13] ide: remove ->ide_dma_on and ->dma_off_quietly methods
 from ide_hwif_t
Date: Wed, 14 Nov 2007 19:31:17 +0300
Message-ID: <473B22D5.5000500@ru.mvista.com>
References: <200711130002.00911.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47119 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754931AbXKNQbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 11:31:07 -0500
In-Reply-To: <200711130002.00911.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Make ide_dma_off_quietly() and __ide_dma_on() always available.

> * Drop "__" prefix from __ide_dma_on().

> * Check for presence of ->dma_host_on instead of ->ide_dma_on.

> * Convert all users of ->ide_dma_on and ->dma_off_quietly methods
>   to use ide_dma_on() and ide_dma_off_quietly() instead.

> * Remove no longer needed ->ide_dma_on and ->dma_off_quietly methods
>   from ide_hwif_t.

> * Make ide_dma_on() void.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
