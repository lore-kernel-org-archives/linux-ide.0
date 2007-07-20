From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/4] alim15x3: PIO mode setup fixes
Date: Fri, 20 Jul 2007 16:50:34 +0400
Message-ID: <46A0AF9A.3060401@ru.mvista.com>
References: <200707201224.33356.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46854 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755993AbXGTMsc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:48:32 -0400
In-Reply-To: <200707201224.33356.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi.

Bartlomiej Zolnierkiewicz wrote:

> * Return failure in ->speedproc method for unsupported/invalid transfer
>   modes passed from user-space (fixes theoretical OOPS in ali_tune_pio()
>   and/or setting random PIO timings on host controller + disabling UDMA
>   bit + setting unsupported/invalid transfer mode on the device).

> * Don't disable UDMA bit when programming PIO modes.

    Not an issue per se sice ide_config_drive_speed() will turn DMA off anyway 
(unless a drive denies to set a given xfer mode).

> * Add FIXME about DMA timings never being set.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
