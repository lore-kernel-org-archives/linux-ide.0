From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] ide: add IDE_HFLAG_NO_DSC host flag
Date: Sat, 29 Dec 2007 16:58:59 +0300
Message-ID: <477652A3.2020900@ru.mvista.com>
References: <200712271838.00351.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12046 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753457AbXL2N6b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Dec 2007 08:58:31 -0500
In-Reply-To: <200712271838.00351.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Add IDE_HFLAG_NO_DSC host flag for hosts that doesn't support DSC overlap.

> * Set it in aec62xx (for ATP850UF only) and hpt34x host drivers.

> * Convert ide-tape device driver to check for IDE_HFLAG_NO_DSC flag.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1098,6 +1098,8 @@ enum {
>  	IDE_HFLAG_CY82C693		= (1 << 27),
>  	/* force host out of "simplex" mode */
>  	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
> +	/* DSC overlap is unsupported */
> +	IDE_HFLAG_NO_DSC		= (1 << 29),
>  };

    Too many flags -- you'll run out of sizeof(unsigned) soon. :-)

MBR, Sergei
