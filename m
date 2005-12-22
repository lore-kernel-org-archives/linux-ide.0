From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: cold plug support
Date: Thu, 22 Dec 2005 14:17:14 +0100
Message-ID: <43AAA75A.8080303@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vvv.conterra.de ([212.124.44.162]:39835 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S965034AbVLVNRV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2005 08:17:21 -0500
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id 3255D1F405B
	for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2005 14:17:20 +0100 (CET)
Received: from conterra.de ([127.0.0.1])
 by localhost (vvv.conterra.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08993-07 for <linux-ide@vger.kernel.org>;
 Thu, 22 Dec 2005 14:17:14 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I followed the recent discussion about ACPI and hotplug and understand
some of the complications with ACPI if the event is triggered by the
device itself, if it is disrupted unexpectedly.

What I need, however, would be the possibility, just to replace a disks
without reboot. I will umount it first and then suspend/shutdown it som=
ehow,
so it should disappear from /sys/block. Thus I can safely unplug it and=
 attach
a new disk. If my hardware is unable to recognize the new disk instanta=
neously
this is not a problem. I may easily activate some scanning process to f=
ind
and activate the new disk. To accomplish this, IMHO there is no need to=
 solve
all the hotplug problems first.

This would be a BIG enhancement for me (and may be others) to keep my d=
isk
servers up and running. May be some of these steps are already implemen=
ted,
but then I'm missing some HOWTO. Else I like to hear if his kind of col=
d-plug
is aimed some day, or if nobody really needs this besides be :-)

Dieter.
--=20
Dieter St=FCken, con terra GmbH, M=FCnster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
