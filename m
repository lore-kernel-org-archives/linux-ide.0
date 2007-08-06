From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/11] ide-pmac: add PIO autotune fallback to ->ide_dma_check
Date: Mon, 06 Aug 2007 20:43:38 +0400
Message-ID: <46B74FBA.6070408@ru.mvista.com>
References: <200708042212.19711.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10505 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759044AbXHFQlg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 12:41:36 -0400
In-Reply-To: <200708042212.19711.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> Since ide-pmac allows separate PIO and DMA timings, and ide-pmac always sets
> ->autotune this change shouldn't have any other effect than bringing ide-pmac
> driver in-line with other host drivers wrt ->ide_dma_check implementation.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
