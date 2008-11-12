From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] pata-rb532-cf: fix signature of the xfer function
Date: Wed, 12 Nov 2008 03:26:27 +0100
Message-ID: <200811120326.28136.florian@openwrt.org>
References: <1226448821-10933-1-git-send-email-n0-1@freewrt.org> <1226448849-11460-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:60154 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYKLC0f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 21:26:35 -0500
Received: by fg-out-1718.google.com with SMTP id 19so220067fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Nov 2008 18:26:33 -0800 (PST)
In-Reply-To: <1226448849-11460-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hi Phil,

(CC'in Jeff as he is the libata maintainer).

Le Wednesday 12 November 2008 01:14:09 Phil Sutter, vous avez =E9crit=A0=
:
> Per definition, this function should return the number of bytes
> consumed. Also take care of the unlikely case when buflen is not a
> multiple of four; while transferring, the division cuts the remaining
> bytes, so alter the return value accordingly.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Acked-by: Florian Fainelli <florian@openwrt.org>
