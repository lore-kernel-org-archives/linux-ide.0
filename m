From: Erik Postma <e.j.postma+linux-ide@gmail.com>
Subject: Re: PROBLEM: "lost interrupt (Status 0x50)" from DVD drive, long wait
	on 2.6.31 till 2.6.32rc6
Date: Sun, 15 Nov 2009 22:57:48 -0500
Message-ID: <d4db24520911151957s781902e0v2bc9e9c20f3ebdd5@mail.gmail.com>
References: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:51786 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbZKPD5n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 22:57:43 -0500
Received: by fxm21 with SMTP id 21so2298623fxm.21
        for <linux-ide@vger.kernel.org>; Sun, 15 Nov 2009 19:57:48 -0800 (PST)
In-Reply-To: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2009/11/15 Erik Postma <e.j.postma+linux-ide@gmail.com>:
> (...)
> [7.7.] Other information that might be relevant to the problem
> =A0 =A0 =A0 (please look in /proc and include all information that yo=
u
> =A0 =A0 =A0 think to be relevant):
>
> Here's dmesg:
> (...)

Just now I had a boot where it did something different; here's what I
guess is the relevant part of dmesg. This is the same kernel and of
course the same hardware as described in the earlier email. Does the
fact that it's unpredictable mean there's possibly hardware issues?
Still have not seen any sign of trouble on 2.6.30 or earlier.

[    1.344085] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.352564] ata1.00: ATA-7: Hitachi HTS541680J9SA00, SB2OC7DP, max
UDMA/100
[    1.352617] ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth
0/32)
[    1.368586] ata1.00: configured for UDMA/100
[    1.368800] scsi 0:0:0:0: Direct-Access     ATA      Hitachi
HTS54168 SB2O PQ: 0 ANSI: 5
[    1.369155] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[    1.369269] sd 0:0:0:0: [sda] Write Protect is off
[    1.369322] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.369350] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.369564]  sda:
[    1.369847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.660046] usb 2-1: new low speed USB device using ohci_hcd and
address 2
[    1.688065] ata2: SATA link down (SStatus 0 SControl 300)
[    1.756716]  sda1 sda2 sda3 < sda5 sda6 >
[    1.794512] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.852642] ata4.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.10, max
UDMA/33
[    1.868615] ata4.00: configured for UDMA/33
[    1.871398] scsi 3:0:0:0: CD-ROM            MATSHITA DVD-RAM
UJ-850S  1.10 PQ: 0 ANSI: 5
[    1.872289] usb 2-1: configuration #1 chosen from 1 choice
[    6.872066] ata4.00: qc timeout (cmd 0xa0)
[    6.872123] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[    6.872183] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[    6.872184]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[    6.872186]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[    6.872337] ata4.00: status: { DRDY ERR }
[    6.872417] ata4: soft resetting link
[    7.052604] ata4.00: configured for UDMA/33
[    7.053051] ata4: EH complete
[   12.052066] ata4.00: qc timeout (cmd 0xa0)
[   12.052122] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   12.052180] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   12.052181]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   12.052183]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   12.052334] ata4.00: status: { DRDY ERR }
[   12.052411] ata4: soft resetting link
[   12.232604] ata4.00: configured for UDMA/33
[   12.233062] ata4: EH complete
[   17.232063] ata4.00: qc timeout (cmd 0xa0)
[   17.232118] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   17.232176] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   17.232178]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   17.232179]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   17.232330] ata4.00: status: { DRDY ERR }
[   17.232408] ata4: soft resetting link
[   17.412604] ata4.00: configured for UDMA/33
[   17.413063] ata4: EH complete
[   22.412063] ata4.00: qc timeout (cmd 0xa0)
[   22.412119] ata4.00: limiting speed to UDMA/25:PIO4
[   22.412169] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   22.412227] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   22.412228]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   22.412230]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   22.412381] ata4.00: status: { DRDY ERR }
[   22.412458] ata4: soft resetting link
[   22.592604] ata4.00: configured for UDMA/25
[   22.593049] ata4: EH complete
[   27.592063] ata4.00: qc timeout (cmd 0xa0)
[   27.592118] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   27.592176] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   27.592178]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   27.592179]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   27.592330] ata4.00: status: { DRDY ERR }
[   27.592407] ata4: soft resetting link
[   27.772604] ata4.00: configured for UDMA/25
[   27.773093] ata4: EH complete
[   32.772064] ata4.00: qc timeout (cmd 0xa0)
[   32.772119] ata4.00: limiting speed to PIO4
[   32.772167] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   32.772225] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   32.772227]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   32.772228]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   32.772379] ata4.00: status: { DRDY ERR }
[   32.772457] ata4: soft resetting link
[   32.952604] ata4.00: configured for PIO4
[   32.953048] ata4: EH complete
[   37.952064] ata4.00: qc timeout (cmd 0xa0)
[   37.952118] ata4.00: limiting speed to PIO3
[   37.952167] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   37.952225] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   37.952226]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   37.952228]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   37.952379] ata4.00: status: { DRDY ERR }
[   37.952456] ata4: soft resetting link
[   38.132603] ata4.00: configured for PIO3
[   38.133046] ata4: EH complete
[   43.132063] ata4.00: qc timeout (cmd 0xa0)
[   43.132118] ata4.00: limiting speed to PIO0
[   43.132166] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   43.132224] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   43.132226]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   43.132227]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   43.132378] ata4.00: status: { DRDY ERR }
[   43.132455] ata4: soft resetting link
[   43.312660] ata4.00: configured for PIO0
[   43.313124] ata4: EH complete
[   48.312066] ata4.00: qc timeout (cmd 0xa0)
[   48.312122] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x6 frozen
[   48.312180] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   48.312181]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00
00 00
[   48.312183]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)
[   48.312334] ata4.00: status: { DRDY ERR }
[   48.312411] ata4: soft resetting link
[   48.492661] ata4.00: configured for PIO0
[   48.493113] ata4: EH complete
[   48.494341] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
xa/form2 cdda tray
[   48.494398] Uniform CD-ROM driver Revision: 3.20
[   48.494628] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   48.494746] sr 3:0:0:0: Attached scsi generic sg1 type 5
[   48.494822] Freeing unused kernel memory: 568k freed
[   48.495415] Write protecting the kernel text: 4532k
[   48.495503] Write protecting the kernel read-only data: 1880k

Thanks,

Erik Postma.
