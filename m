From: Peter Silva <Peter.A.Silva@gmail.com>
Subject: (unknown)
Date: Wed, 4 Jan 2012 16:23:07 -0500
Message-ID: <CADL7PvhxSsxwNo=EapLiXzry1Pn79b_Tr+fqz0nZuPWZTtAgeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50998 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2ADVXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 16:23:08 -0500
Received: by wgbdr13 with SMTP id dr13so29467727wgb.1
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 13:23:07 -0800 (PST)
Subject: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

This was originally submitted as=C2=A0bugzilla.kernel.org=C2=A0# 37642.=
 =C2=A0I don't
know where to continue followup since that server's demise.  to recap
previous report:

am using the device on a system that was running ubuntu 2.6.38 kernel.
=C2=A0where all six drives in this external RAID unit were presented to=
 the
operating system without issue. (standard ubuntu 11.04 kernel.) I am
not interested in the software raid part, just want to use the
external enclosure as JBOD, and use an os based technology for ganging
the disks.=C2=A0When upgraded to 11.10, with 3.0.0 kernel, the disks un=
its
are no longer recognized.  Tejun Heo asked me to try various bios
options. =C2=A0they were tried and had no effect.  was asked to add a
little code to ahci.c to recognize 91a4. =C2=A0It had no effect.

kernel version is pinned to old one for now.

lspci:
02:00.0 RAID bus controller: HighPoint Technologies, Inc. Device 0622 (=
rev 01)
02:00.1 IDE interface: Marvell Technology Group Ltd. 88SE91A4 SATA
6Gb/s Controller (rev 11)

lspci -n:
02:00.0 0104: 1103:0622 (rev 01)
02:00.1 0101: 1b4b:91a4 (rev 11)
