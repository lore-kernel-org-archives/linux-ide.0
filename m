From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD
Date: Mon, 15 Dec 2008 18:36:43 -0600
Message-ID: <4946F81B.7020408@shaw.ca>
References: <4946C96B.2030603@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33838 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbYLPAg4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Dec 2008 19:36:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCNvh-00005O-Gt
	for linux-ide@vger.kernel.org; Tue, 16 Dec 2008 00:36:53 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 00:36:53 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 00:36:53 +0000
In-Reply-To: <4946C96B.2030603@dsrg.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Lubom=C3=ADr Bulej wrote:
> Hello,
>=20
> after putting a 250G OCZ CORE v2 SSD into my notebook, I have to endu=
re=20
> several invocations of the ata EH before the kernel decides to disabl=
e=20
> NCQ due too many errors. The drive reports NCQ of depth 1, which is=20
> probably useless anyway.
>=20
> The patchlet below saves me the waiting for the completion of several=
=20
> ata EH invocations, but I'm not sure if this is the right solution.=20
> Attached are two dmesg dumps, one with errors and the other with the=20
> patchlet compiled in. Attached is also "hdparm -I" of the drive.

I suspect it's all we can really do. NCQ depth of 1 isn't entirely=20
useless, as using NCQ commands still allows the drive to send/request=20
data for an individual request out of order, which NCQ commands don't=20
allow. However, in this case it would appear that the device is sending=
=20
back a bogus all-zeros FIS to the controller which triggers error handl=
ing.

The "applying bridge limits" part is interesting, that would imply the=20
device's identify data doesn't properly indicate it's actually a SATA=20
device so the kernel assumes it's a PATA device behind a SATA bridge. I=
=20
don't think it's related to the problem but it does suggest that whoeve=
r=20
designed the SATA interface on that thing probably didn't do a ton of=20
validation on it..

