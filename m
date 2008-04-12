From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/5] ide: remove ->dma_vendor{1,3} fields from ide_hwif_t
Date: Sat, 12 Apr 2008 22:55:00 +0400
Message-ID: <48010584.3020406@ru.mvista.com>
References: <200804122105.09585.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45184 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755970AbYDLSzn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 14:55:43 -0400
In-Reply-To: <200804122105.09585.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use 'hwif->dma_base + {1,3}' instead of hwif->dma_vendor{1,3} in
>   pdc202xx_new host driver.

> * Remove no longer needed ->dma_vendor{1,3} fields from ide_hwif_t.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

