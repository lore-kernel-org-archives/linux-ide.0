From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Mon, 12 Jan 2009 15:32:34 +0100
Message-ID: <200901121532.34970.florian@openwrt.org>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <200901111713.28716.florian@openwrt.org> <20090111204355.D9E91400B700@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:62691 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbZALOcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 09:32:45 -0500
Received: by bwz14 with SMTP id 14so32207445bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 06:32:42 -0800 (PST)
In-Reply-To: <20090111204355.D9E91400B700@mail.nwl.cc>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi Phil

Le Sunday 11 January 2009 21:47:07 Phil Sutter, vous avez =C3=A9crit=C2=
=A0:
> No, please not! In fact these changes are obsolete and useless, see m=
y
> later mail to the linux-ide list.
> (Message-ID: 20081128193322.D103C386DBBE@mail.ifyouseekate.net)
>
> Accessing the IRQ this generic way is fine, we just needed code for t=
he
> GPIO mapped IRQs to be handled correctly.

Right, I now remember. Is the pata_rb532_cf in Jeff's tree missing any =
fix=20
from you ?
--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
