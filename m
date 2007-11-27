From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 10/13] libata: add qc->dma_nbytes
Date: Tue, 27 Nov 2007 17:20:11 +0000
Message-ID: <20071127172011.344a9754@the-village.bc.nu>
References: <11961764391983-git-send-email-htejun@gmail.com>
	<11961764413160-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46571 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758238AbXK0RZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 12:25:17 -0500
In-Reply-To: <11961764413160-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Wed, 28 Nov 2007 00:13:56 +0900
Tejun Heo <htejun@gmail.com> wrote:

> qc->nbytes doesn't include extra buffers setup by libata core layer
> and my be odd.  This patch adds qc->dma_nbytes which includes any
> extra buffers setup by libata core layer and is guaranteed to be

Seems sensible. Might be interesting to try 16 byte aligns on the same
basis.

Alan
