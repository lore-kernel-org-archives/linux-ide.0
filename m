From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ata8.00: log page 10h reported inactive tag 0
Date: Wed, 17 Feb 2010 18:25:15 -0600
Message-ID: <4B7C88EB.1040502@gmail.com>
References: <87y6isp4da.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:61594 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0BRAZS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2010 19:25:18 -0500
Received: by gxk27 with SMTP id 27so1979613gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2010 16:25:17 -0800 (PST)
In-Reply-To: <87y6isp4da.fsf@nemi.mork.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: linux-ide@vger.kernel.org

On 02/17/2010 04:02 AM, Bj=C3=B8rn Mork wrote:
> I'm trying to debug a problem I've been having a couple of times over
> the last few weeks, where this machine hangs *really* hard: No consol=
e
> output at all, and absolutely no response on the console - not even
> using the magic SysRq key (using "break" on the serial console.  This=
 is
> tested and known to be fully functional under normal conditions).
>
> I really have no clue where to start to locate the cause of this, but
> after rebooting the last time there were a few libata error messages
> which puzzle me so I might as well start here.  Understandig these
> errors will be useful in itself.  And they are related to the last
> pieces of hardware added (SiI 3132 controller attached to a SiI 4726
> port multiplier with 3 disks), which make them more suspicious in my
> eyes...
>
> These are the messages I worry about (full dmesg is included below):
>
> [   63.865723] ata8.00: log page 10h reported inactive tag 0
> [   63.943744] ata8.00: exception Emask 0x1 SAct 0x3c SErr 0x0 action=
 0x0
> [   64.107789] ata8.00: irq_stat 0x03060002, device error via SDB FIS
> [   64.199764] ata8.00: cmd 60/08:10:00:02:00/00:00:00:00:00/40 tag 2=
 ncq 4096 in
> [   64.199765]          res 60/08:10:00:02:00/00:00:00:00:00/40 Emask=
 0x1 (device error)
> [   64.580730] ata8.00: status: { DRDY DF }
> [   64.628731] ata8.00: cmd 60/78:18:08:02:00/00:00:00:00:00/40 tag 3=
 ncq 61440 in
> [   64.628732]          res 60/78:18:08:02:00/00:00:00:00:00/40 Emask=
 0x89 (media error)
> [   64.810084] ata8.00: status: { DRDY DF }
> [   64.879835] ata8.00: error: { UNC IDNF }
> [   64.930935] ata8.00: cmd 60/18:20:e8:00:00/00:00:00:00:00/40 tag 4=
 ncq 12288 in
> [   64.930936]          res 56/1b:02:02:00:00/00:00:00:40:56/00 Emask=
 0x1 (device error)
> [   65.204495] ata8.00: status: { DRDY }
> [   65.248497] ata8.00: error: { IDNF }
> [   65.292407] ata8.00: cmd 60/80:28:80:01:00/00:00:00:00:00/40 tag 5=
 ncq 65536 in
> [   65.292408]          res 56/1b:02:02:00:00/00:00:00:50:56/00 Emask=
 0x1 (device error)
> [   65.590268] ata8.00: status: { DRDY }
> [   65.658016] ata8.00: error: { IDNF }
> [   65.725346] ata8.00: configured for UDMA/100
> [   65.780607] sd 7:0:0:0: [sdd] Device not ready: Sense Key : Not Re=
ady [current] [descriptor]
> [   65.925384] sd 7:0:0:0: [sdd] Device not ready: Add. Sense: Logica=
l unit not ready, cause not reportable
> [   66.040355] end_request: I/O error, dev sdd, sector 520
> [   66.103442] ata8: EH complete
> [   66.137877] sd 7:0:0:0: [sdd] 3907029168 512-byte hardware sectors=
 (2000399 MB)
> [   66.228486] sd 7:0:0:0: [sdd] Write Protect is off
> [   66.285654] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [   66.285676] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
>
>
> These errors appeared after power cycling the hanging machine, and ma=
y
> therefore just as well be symptoms as a cause.  As you see, the error
> handling is successful and all drives are working as expected.  So I
> guess this might just be a harmless warning caused by an unrelated ha=
ng
> and the unexpected power cycling. Anyway, here are the details of thi=
s
> controller in case they are of interest:

Well, that error indicates a read error on some sectors reported by the=
=20
drive. This could be caused by a hard power-down in the middle of a=20
write to those sectors - in that case, one can in principle use=20
something like hdparm --write-sector to rewrite the sector correctly.=20
However, it could also be due to a drive fault.
