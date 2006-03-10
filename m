From: Jure =?UTF-8?Q?Pe=C4=8Dar?= <pegasus@nerv.eu.org>
Subject: gigabyte iRam not seen by linux
Date: Fri, 10 Mar 2006 01:36:04 +0100
Message-ID: <20060310013604.1acac722.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.pecar.org ([193.95.219.68]:30243 "EHLO mail.pecar.org")
	by vger.kernel.org with ESMTP id S1752162AbWCJAfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2006 19:35:53 -0500
Received: from localhost.localdomain (unknown [192.168.0.13])
	by mail.pecar.org (Postfix) with ESMTP id CF74816094
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:35:55 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi all,

I just got a gigabyte solid state disk on a test. However, it is not se=
en by linux. The problem is described well here:
http://www.linuxquestions.org/questions/showthread.php?t=3D411600

What can one do when there *is* something on the sata port but the driv=
er doesn't recognize it? It's not even in the /sys/block/ or /sys/bus/s=
csi/ ...  If I don't have the device, I can't use sg utils to ask it ho=
w it feels ...=20

I'd really want to use this ssd under linux, but I don't know how to de=
bug the problem from here.


--=20

Jure Pe=C4=8Dar
http://jure.pecar.org/
