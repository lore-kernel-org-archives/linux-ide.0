From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] amd74xx/via82cxxx: check ide_config_drive_speed() return
 value
Date: Sun, 29 Jul 2007 14:33:17 +0400
Message-ID: <46AC6CED.4090601@ru.mvista.com>
References: <200707262156.00679.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55563 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761284AbXG2KbR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 06:31:17 -0400
In-Reply-To: <200707262156.00679.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Check ide_config_drive_speed() return value.

> * While at also call ide_config_drive_speed() if the transfer mode is
>   XFER_PIO_SLOW (this case happens iff the transfer mode has already been
>   set on the device by ide-proc.c::set_xfer_rate()) and remove redundant
>   setting of ->{init,current}_speed.

> * Bump driver version.

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

PS: There's no need to notify about Acked-by: addition I think -- would save 
everyone a keystroke or two... ;-)
