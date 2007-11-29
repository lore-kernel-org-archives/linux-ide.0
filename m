From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/14] libata: add qc->dma_nbytes
Date: Thu, 29 Nov 2007 16:02:09 +0000
Message-ID: <20071129160209.31027324@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468193821-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58297 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756818AbXK2QG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:06:57 -0500
In-Reply-To: <11963468193821-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Thu, 29 Nov 2007 23:33:34 +0900
Tejun Heo <htejun@gmail.com> wrote:

> qc->nbytes doesn't include extra buffers setup by libata core layer
> and my be odd.  This patch adds qc->dma_nbytes which includes any
> extra buffers setup by libata core layer and is guaranteed to be
> aligned on 4 byte boundary.

Acked-by: Alan Cox <alan@redhat.com>


May be worth eventually making the alignment a variable in the host
