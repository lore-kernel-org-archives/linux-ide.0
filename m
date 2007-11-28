From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] ide-pmac: use custom hwif->sg_max_nents only if DMA
 support is enabled
Date: Wed, 28 Nov 2007 14:43:27 +0300
Message-ID: <474D545F.2070607@ru.mvista.com>
References: <200711280000.14973.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53901 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754606AbXK1LnO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 06:43:14 -0500
In-Reply-To: <200711280000.14973.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> Move setting hwif->sg_max_nents from pmac_ide_setup_device()
> to pmac_ide_setup_dma().

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
