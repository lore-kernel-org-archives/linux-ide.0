From: Peter Silva <Peter.A.Silva@gmail.com>
Subject: highpoint rocketraid 622 regression, no longer recognized post 3.0 kernel.
Date: Wed, 4 Jan 2012 16:24:13 -0500
Message-ID: <CADL7PvjzZaADGGPO6J1yRtSPjTzcbMOPu-oerkrtQrW0UVWRRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45467 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935Ab2ADVYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 16:24:14 -0500
Received: by wibhm6 with SMTP id hm6so10236518wib.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 13:24:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

This was originally submitted as bugzilla.kernel.org # 37642.  I don't
know where to continue followup since that server's demise.  to recap
previous report:

am using the device on a system that was running ubuntu 2.6.38 kernel.
 where all six drives in this external RAID unit were presented to the
operating system without issue. (standard ubuntu 11.04 kernel.) I am
not interested in the software raid part, just want to use the
external enclosure as JBOD, and use an os based technology for ganging
the disks. When upgraded to 11.10, with 3.0.0 kernel, the disks units
are no longer recognized.  Tejun Heo asked me to try various bios
options.  they were tried and had no effect.  was asked to add a
little code to ahci.c to recognize 91a4.  It had no effect.

kernel version is pinned to old one for now.

lspci:
02:00.0 RAID bus controller: HighPoint Technologies, Inc. Device 0622 (rev 01)
02:00.1 IDE interface: Marvell Technology Group Ltd. 88SE91A4 SATA
6Gb/s Controller (rev 11)

lspci -n:
02:00.0 0104: 1103:0622 (rev 01)
02:00.1 0101: 1b4b:91a4 (rev 11)
