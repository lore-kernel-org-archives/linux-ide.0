From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE update
Date: Wed, 09 May 2007 18:47:23 -0400
Message-ID: <46424F7B.8060004@garzik.org>
References: <200705100046.05280.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49577 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbXEIWrZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 18:47:25 -0400
In-Reply-To: <200705100046.05280.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Bartlomiej Zolnierkiewicz wrote:
> * the code for selecting and programming the best DMA transfer mode
>   has been reworked to be cleaner, more generic and more libata-like,
>   (> 500 LOCs gone and this change allows the change described below)

> Bartlomiej Zolnierkiewicz (11):
>       ide: rework the code for selecting the best DMA transfer mode (v3)


Has this seen testing/exposure in -mm tree?

	Jeff


