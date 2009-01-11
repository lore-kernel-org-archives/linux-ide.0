From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sun, 11 Jan 2009 21:47:07 +0100
Message-ID: <20090111204355.D9E91400B700@mail.nwl.cc>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <1226448783-10047-1-git-send-email-n0-1@freewrt.org> <491E0F88.5000808@garzik.org> <200901111713.28716.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ks361647.kimsufi.com ([91.121.169.95]:55139 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbZAKUym (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jan 2009 15:54:42 -0500
Content-Disposition: inline
In-Reply-To: <200901111713.28716.florian@openwrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi,

On Sun, Jan 11, 2009 at 05:13:28PM +0100, Florian Fainelli wrote:
> Hello Jeff,
>=20
> Le Saturday 15 November 2008 00:53:44 Jeff Garzik, vous avez =C3=A9cr=
it=C2=A0:
> > I'll need to wait for this function to appear upstream... it's not =
in
> > 2.6.28-rc at least
>=20
> I just checked that you now got this function in your libata-dev tree=
, this=20
> patch still applies, can you merge it ? Thanks a lot.

No, please not! In fact these changes are obsolete and useless, see my
later mail to the linux-ide list.
(Message-ID: 20081128193322.D103C386DBBE@mail.ifyouseekate.net)

Accessing the IRQ this generic way is fine, we just needed code for the
GPIO mapped IRQs to be handled correctly.

Greetings, Phil
