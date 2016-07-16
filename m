From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RESEND PATCH] arm: colibri_pxa270_defconfig: disable IDE subsystem
Date: Sat, 16 Jul 2016 11:01:41 +0200
Message-ID: <871t2u2byi.fsf@belgarion.home>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
	<1467991490-24895-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:45128 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcGPJBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2016 05:01:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> This patch disables deprecated IDE subsystem in colibri_pxa270_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
Hi Bartlomiej,

It seems I have missed that serie a year ago ...
I can't remember why I have not taken it in at that time, I'm still going
through my mails ...

If I don't find anything relevant, and given that I'm not expecting anyone to
object, I'm going to queue that in pxa/for-next within the next week.

Cheers.

-- 
Robert
