From: Robert Hancock <hancockrwd@gmail.com>
Subject: JMB363 false hotplug detections (was: ahci: AHCI and RAID mode SATA
	patch for Intel Cougar Point DeviceIDs)
Date: Sat, 16 Jan 2010 12:10:08 -0600
Message-ID: <51f3faa71001161010m47d885cfx5d17486016476ed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:42076 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab0APSKJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 13:10:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Sat, Jan 16, 2010 at 12:02 PM, Krzysztof Halasa <khc@pm.waw.pl> wrot=
e:
> Robert Hancock <hancockrwd@gmail.com> writes:
>
>> Hmm.. From those test results I really suspect some kind of hardware
>> fault. Could be a defective motherboard - I don't know if that chip
>> needs any terminating resistors on the motherboard for the SATA sign=
al
>> lines or something, if so, could be they weren't installed properly.=
=2E
>
> Unfortunately I can't find a JMB363 datasheet on the net, but there i=
s
> a certain mb (p965t-a) schematic available.
> It seems JMB363 doesn't need terminators on SATA RX/TX lines, there i=
s
> capacitative coupling only (10 nF in each line).
>
> The port in question (SATA#2) on my mb (P45 Neo2) uses pins 56 (RXP)
> 57 (RXN) and 60 (TXN) 61 (TXP). No visible irregularity, the traces l=
ook
> like they should, go straigt to the capacitors, and then to 0R R-pack=
s
> and to the connector. It looks exactly the same for both ports. There=
 is
> no short circuit past the capacitors (from the connector side). I'd s=
ay
> quite low probability that there is something wrong with these signal=
s.
>
> It seems the chip uses extra 12k resistors for SATA (p965t-a calls th=
e
> pins SJ_REXT[12]), pin 44 for port#1 and 55 for port#2. Both look san=
e.
> I will check the suspected connections with the machine powered off
> later.
>
> The RX and TX trace pairs go next to each other for up to 10 mm, coul=
d
> that be a problem at these frequencies? If so it would show up on
> all/many such boards certainly? Can't find any report.
>
> OTOH other people have similar problems with other boards: e.g.
> ASUS P5KC: http://ubuntuforums.org/showthread.php?t=3D766217
> =A0 =A0 =A0 =A0 =A0 https://bugs.launchpad.net/ubuntu/+source/linux/+=
bug/377633
>
> (unknown boards)
> https://archlinux-fr.org/doku.php?id=3Dsecurisation:logcheck
> http://forum.ubuntu-fr.org/viewtopic.php?pid=3D2739616
> http://ubuntu-ky.ubuntuforums.org/showthread.php?p=3D7243061
> The last one claims:
> this started after an upgrade to ubuntu 9.04 and is stll here after r=
e-installing
> ubuntu 8.10.
> this was fixed by re-installing ubuntu 8.10 only using the kernal,
> 2.6.27-7-generic.
> I don't know if JMB36x is involved in this case, and how reliable the
> info is.
>
> Investigating as time permits.

Well, it is possible there is some kind of flaw in the JMB363 chip
itself  that causes this problem. (Could be it happens in Windows too,
I don't think Windows drivers normally report these kinds of events
anywhere and if it never reached the point of actually deciding a
device was connected, you likely wouldn't notice.) I suppose we could
add a workaround in the driver to ignore hotplug events, but then real
hotplug events wouldn't get handled properly..

What revision does your JMB363 report in lspci? Mine shows:

03:00.0 SATA controller: JMicron Technologies, Inc. 20360/20363 Serial
ATA Controller (rev 03) (prog-if 01 [AHCI 1.0])

Tejun, any other ideas?
