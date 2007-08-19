From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/7] ide: remove CONFIG_IDEDMA_ONLYDISK
Date: Sun, 19 Aug 2007 18:32:22 +0400
Message-ID: <46C85476.1080007@ru.mvista.com>
References: <200708182051.26177.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61351 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753473AbXHSO37 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 10:29:59 -0400
In-Reply-To: <200708182051.26177.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> ATAPI devices with broken DMA support should be handled by DMA blacklist
> and for debugging purposes we have new shiny "hdx=nodma" kernel paremeter.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

