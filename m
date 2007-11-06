From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 16/18] ide: remove redundant ->ide_dma_on call from set_using_dma()
Date: Tue, 06 Nov 2007 14:44:44 +0300
Message-ID: <473053AC.8080902@ru.mvista.com>
References: <200711050033.19699.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30685 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754779AbXKFLoa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:44:30 -0500
In-Reply-To: <200711050033.19699.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ide_set_dma() calls ->ide_dma_on method itself and returns zero
> only if ->ide_dma_on call succeeded.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
