From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/12] scc_pata: PIO fixes
Date: Mon, 09 Jul 2007 21:38:24 +0400
Message-ID: <46927290.3040205@ru.mvista.com>
References: <200707081537.45090.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:4963 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754265AbXGIRgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 13:36:22 -0400
In-Reply-To: <200707081537.45090.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Use pio == 255 == "auto-tune" in scc_config_drive_for_dma() instead of
>   forcing PIO4 on PIO fallback.  Fix comment while at it.

> * Rename scc_tuneproc() to scc_tune_pio() and add scc_tuneproc() wrapper.
>   Move finding of the best PIO mode and setting of transfer mode on the device
>   to the new wrapper.

> * Fix scc_tune_chipset() to tune PIO modes.  Do a small cleanup while at it.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
