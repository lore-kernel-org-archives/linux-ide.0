From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/9] ide: remove 'byte' typedef
Date: Fri, 19 Dec 2008 14:54:33 +0300
Message-ID: <494B8B79.4090805@ru.mvista.com>
References: <20081216193137.3959.70339.sendpatchset@localhost.localdomain> <20081216193210.3959.92852.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51663 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750874AbYLSLyi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Dec 2008 06:54:38 -0500
In-Reply-To: <20081216193210.3959.92852.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Just use u8 instead, also s/__u8/u8/ in ide-cd.h while at it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/qd65xx.h
> ===================================================================
> --- a/drivers/ide/qd65xx.h
> +++ b/drivers/ide/qd65xx.h
> @@ -31,8 +31,8 @@
>  
>  #define QD_CONFIG(hwif)		((hwif)->config_data & 0x00ff)
>  
> -#define QD_TIMING(drive)	(byte)(((drive)->drive_data) & 0x00ff)
> -#define QD_TIMREG(drive)	(byte)((((drive)->drive_data) & 0xff00) >> 8)
> +#define QD_TIMING(drive)	(u8)(((drive)->drive_data) & 0x00ff)
> +#define QD_TIMREG(drive)	(u8)((((drive)->drive_data) & 0xff00) >> 8)
>   

   Could you drop the pointless parens around (drive)->drive_data, while 
at it?

MBR, Sergei


