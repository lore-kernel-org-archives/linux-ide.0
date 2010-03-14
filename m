From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: nvidia controller failed command, possibly related to SMART selftest
 (2.6.32)
Date: Sun, 14 Mar 2010 10:16:29 -0600
Message-ID: <4B9D0BDD.4030706@gmail.com>
References: <20100313092559.GA14213@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:48412 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab0CNQQc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2010 12:16:32 -0400
In-Reply-To: <20100313092559.GA14213@piper.oerlikon.madduck.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ide <linux-ide@vger.kernel.org>

(ccing linux-ide)

On 03/13/2010 03:25 AM, martin f krafft wrote:
> Hello,
>
> I swapped in a new motherboard into a server that was previously
> having the occasional SATA hiccoughs[0]. It didn't last 24 hours
> before I got the next set of troubles:
>
> 0. http://marc.info/?l=3Dlinux-kernel&m=3D125654588201284&w=3D2
>
>    kernel: [45091.756037] ata4: EH in SWNCQ mode,QC:qc_active 0x1 sac=
tive 0x1
>    kernel: [45091.756042] ata4: SWNCQ:qc_active 0x1 defer_bits 0x0 la=
st_issue_tag 0x0
>    kernel: [45091.756043]   dhfis 0x1 dmafis 0x0 sdbfis 0x0
>    kernel: [45091.756046] ata4: ATA_REG 0x40 ERR_REG 0x0
>    kernel: [45091.756048] ata4: tag : dhfis dmafis sdbfis sacitve
>    kernel: [45091.756051] ata4: tag 0x0: 1 0 0 1
>    kernel: [45091.756063] ata4.00: exception Emask 0x0 SAct 0x1 SErr =
0x0 action 0x6 frozen
>    kernel: [45091.756068] ata4.00: failed command: WRITE FPDMA QUEUED
>    kernel: [45091.756074] ata4.00: cmd 61/08:00:07:30:e1/00:00:01:00:=
00/40 tag 0 ncq 4096 out
>    kernel: [45091.756075]          res 40/00:00:01:4f:c2/00:00:00:00:=
00/00 Emask 0x4 (timeout)
>    kernel: [45091.756077] ata4.00: status: { DRDY }
>    kernel: [45091.756085] ata4: hard resetting link
>    kernel: [45091.756087] ata4: nv: skipping hardreset on occupied po=
rt
>    kernel: [45097.264713] ata4: link is slow to respond, please be pa=
tient (ready=3D0)
>    kernel: [45101.800044] ata4: SRST failed (errno=3D-16)
>                           [=E2=80=A6]
>    kernel: [45151.900793] ata4: reset failed, giving up
>    kernel: [45151.900797] ata4.00: disabled
>    kernel: [45151.900851] sd 3:0:0:0: [sdd] Unhandled error code
>    kernel: [45151.900853] sd 3:0:0:0: [sdd] Result: hostbyte=3DDID_BA=
D_TARGET driverbyte=3DDRIVER_OK
>    kernel: [45151.900856] sd 3:0:0:0: [sdd] CDB: Write(10): 2a 00 01 =
e1 30 07 00 00 08 00
>    kernel: [45151.900864] end_request: I/O error, dev sdd, sector 315=
35111
>    kernel: [45151.900870] raid1: Disk failure on sdd2, disabling devi=
ce.
>    kernel: [45151.900871] raid1: Operation continuing on 1 devices.
>
> How do I learn how to interpret such kernel logs?
> Does it suggest anything about who's at fault?

Well, it seems like a genuine timeout, though it's not clear why the=20
reset ended up failing afterwards. It could be that the drive's=20
implementation of the SMART self test is buggy (it's supposed to still=20
respond to host commands while it's running, but it could be it doesn't=
=20
always, or takes so long to respond that the kernel times out).

>
> If it's of any relevance, the problems also occured with 2.6.26, but
> the RAID code didn't always eject the disks on that kernel; the
> first time I encountered a degraded array due to this was shortly
> after the upgrade to 2.6.32. However, this is speculation, I have
> not verified the causality.
>
>
> All this happened at 2:09am, which made me wonder about smartd, and
> indeed this is the time I scheduled SMART self-tests on the device.
>
> What's more: I can reproduce the problem at will, e.g. run a short
> SMART self-test and a RAID resync on the device at the same time,
> and boom!
>
> However, I can only reproduce this on two disks, which are on
> separate SATA controller channels ata2 and ata4, which makes me
> think that the problems are with the disks, not with the controller
> (ata1 and ata3 stand up fine to the stress test)
>
> Generally, SMART self-tests should be a transparent operation that
> doesn't affect the operating system's use of the devices, right? Is
> it conceivable or even common that the disks' own controllers are
> broken to the point where they fall over SMART tests?
>
> Thank you for any feedback,
>

