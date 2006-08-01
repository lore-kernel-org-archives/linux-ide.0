From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.18-rc2-mm1] pata_via fails
Date: Wed, 02 Aug 2006 00:45:05 +0100
Message-ID: <1154475905.15540.121.camel@localhost.localdomain>
References: <20060802010415.2bebc5fc@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:26329 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750741AbWHAX0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 19:26:00 -0400
In-Reply-To: <20060802010415.2bebc5fc@werewolf.auna.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "J.A. =?ISO-8859-1?Q?Magall=F3n?=" <jamagallon@ono.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Ar Mer, 2006-08-02 am 01:04 +0200, ysgrifennodd J.A. Magall=C3=B3n:
> Yes, generic subject ;)
>=20
> After solving the problems with ICH, one other stays. One box has a
> VIA controller (in fact, this is a ApolloPro 266 chipset motherboard)=
:

Known insanity. With some ATAPI devices the VIA delivers the IRQ before
the response is ready when we do a SET_FEATURES. Still being worked on.

Alan

