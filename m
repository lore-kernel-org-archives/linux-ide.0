From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch][0/6] ide: sanitize PIO code, take 2
Date: Sun, 12 Sep 2004 20:34:48 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4144EB28.6070401@pobox.com>
References: <200409110026.20064.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264396AbUIMAfB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Sep 2004 20:35:01 -0400
In-Reply-To: <200409110026.20064.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

Bartlomiej Zolnierkiewicz wrote:
> - bugfix: use sg->length instead of sg_dma_len(sg)
>   (found thanks to rmk's concerns)

Details?

IIRC this breaks ia64 and/or other platforms?

	Jeff


