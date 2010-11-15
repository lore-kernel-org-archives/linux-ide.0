From: James Cloos <cloos@jhcloos.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Mon, 15 Nov 2010 11:39:31 -0500
Message-ID: <m3wroek0bo.fsf@jhcloos.com>
References: <m3mxpbn69i.fsf@jhcloos.com> <4CE0B247.50002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:34165 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973Ab0KOQqO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2010 11:46:14 -0500
In-Reply-To: <4CE0B247.50002@garzik.org> (Jeff Garzik's message of "Sun, 14
	Nov 2010 23:08:39 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

>>>>> "JG" =3D=3D Jeff Garzik <jeff@garzik.org> writes:

JG> No, on SATA each link is entirely independent of the other links
JG> (ignoring port multipliers).

That is what I thought.

JG> The "3 Gbps" maximum you see on the first line comes directly from
JG> what capabilities the chip reports, so perhaps the firmware/BIOS is
JG> not initializing the chip properly.

And that is what I was afraid of. =E2=98=B9

JG> AHCI 1.2 hardware, the AHCI driver and libata core should all suppo=
rt
JG> operation at 6 Gbps.

Again, what I thought.

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
