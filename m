From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Thu, 30 Oct 2008 23:39:24 +0100
Message-ID: <200810302339.25022.florian@openwrt.org>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:24244 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYJ3XIA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Oct 2008 19:08:00 -0400
Received: by ug-out-1314.google.com with SMTP id 39so1109168ugf.37
        for <linux-ide@vger.kernel.org>; Thu, 30 Oct 2008 16:07:57 -0700 (PDT)
In-Reply-To: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org

Hi Phil,

Le Thursday 30 October 2008 22:47:31 Phil Sutter, vous avez =E9crit=A0:
> After applying the following changes I could verify functionality by
> mounting a filesystem on the cfdisk and reading/writing files in it.
>
> The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not ye=
t
> available in a vanilla kernel, an appropriate patch has already been
> sent to the linux-mips mailinglist.

Thanks a lot for fixing this.

>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>

Acked-by: Florian Fainelli <florian@openwrt.org>
--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
