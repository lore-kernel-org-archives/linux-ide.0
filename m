From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/13] icside: add ide_toggle_bounce() calls
Date: Tue, 13 Nov 2007 14:21:07 +0300
Message-ID: <473988A3.1080204@ru.mvista.com>
References: <200711130001.49683.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:31807 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751620AbXKMLUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 06:20:55 -0500
In-Reply-To: <200711130001.49683.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Bartlomiej Zolnierkiewicz wrote:

> Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
> methods so they match generic __ide_dma_on()/ide_dma_off_quietly().

> Since there is no PCI device there should be no functionality
> changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
