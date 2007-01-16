From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: ICH7m problem using libata
Date: Tue, 16 Jan 2007 15:11:18 +0100 (MET)
Message-ID: <200701161411.l0GEBI26026412@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:61459 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbXAPOL2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 09:11:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jangutter@gmail.com
Cc: linux-ide@vger.kernel.org, matthew4196@gmail.com

On Tue, 16 Jan 2007 15:53:14 +0200, Jan Gutter wrote:
> On Tue, 2007-01-16 at 20:42 +0900, Tejun Heo wrote:
> > Can you try 2.6.20-rc5?  It has better error reporting and will tell us
> > which SCSI command is timing out.
> 
> Here you go: attaching dmesg
...
> nvidia: module license 'NVIDIA' taints kernel.
...
> NVRM: loading NVIDIA UNIX x86 Kernel Module  1.0-9746  Fri Dec 15 09:54:45 PST 2006
> EXT3 FS on sda7, internal journal
> Adding 2104472k swap on /dev/sda6.  Priority:-1 extents:1 across:2104472k
> Real Time Clock Driver v1.12ac
> ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
> **WARNING** I2C adapter driver [NVIDIA i2c adapter 0 at 1:00.0] forgot to specify physical device; fix it!
> **WARNING** I2C adapter driver [NVIDIA i2c adapter 1 at 1:00.0] forgot to specify physical device; fix it!
> **WARNING** I2C adapter driver [NVIDIA i2c adapter 2 at 1:00.0] forgot to specify physical device; fix it!
> ipw3945: Error sending SCAN_ABORT_CMD: time out after 500ms.
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x43 data 12 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1: soft resetting port
> ata1.00: configured for UDMA/100
> ata1.01: configured for UDMA/33
> ata1: EH complete

Tainted kernel. Try again without the nvidia module.
