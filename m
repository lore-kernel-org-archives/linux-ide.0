From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: cold plug support
Date: Sat, 14 Jan 2006 12:13:55 +0200
Message-ID: <pan.2006.01.14.10.13.55.774705@yahoo.com>
References: <43AAA75A.8080303@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:29407 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751676AbWANKQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2006 05:16:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExiRu-00023t-6r
	for linux-ide@vger.kernel.org; Sat, 14 Jan 2006 11:15:54 +0100
Received: from ibmrom-dt.b.astral.ro ([195.7.6.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 14 Jan 2006 11:15:54 +0100
Received: from i_p_a_u_l by ibmrom-dt.b.astral.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 14 Jan 2006 11:15:54 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Thu, 22 Dec 2005 14:17:14 +0100, Dieter St=FCken wrote:

> I followed the recent discussion about ACPI and hotplug and understan=
d
> some of the complications with ACPI if the event is triggered by the
> device itself, if it is disrupted unexpectedly.
>=20
> What I need, however, would be the possibility, just to replace a dis=
ks
> without reboot. I will umount it first and then suspend/shutdown it
> somehow, so it should disappear from /sys/block. Thus I can safely un=
plug
> it and attach a new disk. If my hardware is unable to recognize the n=
ew
> disk instantaneously this is not a problem. I may easily activate som=
e
> scanning process to find and activate the new disk. To accomplish thi=
s,
> IMHO there is no need to solve all the hotplug problems first.
>=20
> This would be a BIG enhancement for me (and may be others) to keep my=
 disk
> servers up and running. May be some of these steps are already
> implemented, but then I'm missing some HOWTO. Else I like to hear if =
his
> kind of cold-plug is aimed some day, or if nobody really needs this
> besides be :-)
>=20
> Dieter.

Hello Dieter,

You are not alone,
Me and some of my friends also will benefit from some sort of cold-plug=
 if
possible. If you found something, please let us know.

Thanks,
Paul

