From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/13] ide-cris: fix DMA methods
Date: Fri, 07 Dec 2007 19:52:50 +0300
Message-ID: <47597A62.6050502@ru.mvista.com>
References: <200711130002.06806.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26335 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753398AbXLGQwe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 11:52:34 -0500
In-Reply-To: <200711130002.06806.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>

Bartlomiej Zolnierkiewicz wrote:

> * Rename cris_dma_{on,off}() to cris_dma_host_{on,off}().

> * Remove no longer needed ->dma_off_quietly
>   (IDE core has the needed code now).

> * Make cris_dma_host_on() void.

> Cc: Mikael Starvik <starvik@axis.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
