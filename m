From: =?ISO-8859-1?Q?Sebastian_Mu=F1iz?= <sjmuniz@gmail.com>
Subject: PCIe SiI 3132 2xeSATA vs JMB393 6 PM
Date: Wed, 7 Dec 2011 18:47:52 -0300
Message-ID: <CAMBB+Zxb3CHrv3JMJBvpq4nE5ZyrJbH0SviE2JPM=ADENaaifQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33187 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904Ab1LGVsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2011 16:48:14 -0500
Received: by eekd41 with SMTP id d41so876620eek.19
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2011 13:48:13 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello
I am have connected a 5 disk box ultracheap Lian Li EX-503B to a
server running XenServer 5.5.
The box is configured as raid0 with two disks and the server has a
PCIe Sil 3132.
In this circumstances the server is unable to use NCQ.

This is the card as seen with lspci -v
06:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA
Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. Unknown device 7132
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at e8304000 (64-bit, non-prefetchable) [size=3D128]
        Memory at e8300000 (64-bit, non-prefetchable) [size=3D16K]
        I/O ports at 2000 [size=3D128]
        [virtual] Expansion ROM at e8700000 [disabled] [size=3D512K]
        Capabilities: [54] Power Management version 2
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=3D0/0 Enable-
        Capabilities: [70] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting


This is the port as seen with lsscsi
[7]    sata_sil24
  dir: /sys/class/scsi_host/host7
  device dir: /sys/devices/pci0000:00/0000:00:01.0/0000:06:00.0/host7

This is the device on it
[7:0:0:0]    disk    ATA      Lian Li H/W RAID 0957  /dev/sdb
  state=3Drunning queue_depth=3D1 scsi_level=3D6 type=3D0 device_blocke=
d=3D0 timeout=3D60
  dir: /sys/bus/scsi/devices/7:0:0:0
[/sys/devices/pci0000:00/0000:00:01.0/0000:06:00.0/host7/target7:0:0/7:=
0:0:0]

Is this expected, like a known issue between JMB393 against sil3132 ?
I was hoping to put 5 x 2Tbytes disks on this box, configure raid5 and
be happy for once.

Thanks in advance,
Sebastian Mu=F1iz


--=20

I've decided that the stuff falling through the cracks
is confetti and I'm having a party!=94
