From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: add ->max_sectors field to struct ide_port_info
Date: Sat, 22 Nov 2008 16:17:12 +0300
Message-ID: <49280658.9080606@ru.mvista.com>
References: <200811212242.08182.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [63.81.120.155] ([63.81.120.155]:22250 "EHLO imap.sh.mvista.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757631AbYKVNRR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 08:17:17 -0500
In-Reply-To: <200811212242.08182.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add ->max_sectors field to struct ide_port_info to allow host drivers
>   to specify value used for hwif->rqsize (if smaller than the default).
>
> * Convert pdc202xx_old to use ->max_sectors and remove no longer needed
>   IDE_HFLAG_RQSIZE_256 flag.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>

MBR, Sergei


