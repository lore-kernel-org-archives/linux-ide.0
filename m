From: Kuckuck Kuckuck <gentoopower@yahoo.de>
Subject: AW: Possible NCQ problem with Seagate ST3250620NS/nForce 4
Date: Wed, 24 Oct 2007 21:01:51 +0000 (GMT)
Message-ID: <773425.40044.qm@web26007.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26007.mail.ukl.yahoo.com ([217.12.10.218]:25373 "HELO
	web26007.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753427AbXJXVBx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 17:01:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?Q?Jens_Pr=FCfer?= <jens.pruefer@gmx.de>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jens,

I had the same problem a few month ago when ADMA with NFORCE4 was intro=
duced in 2.6.21 kernel.
I suspected a SAMSUNG HD401LJ to be the bad drive.
Someone from the list mentioned that a bad/weak PSU may be responsible =
for the trouble.
It was hard for me to believe that this was the case, since my system o=
nly uses 130W at full load and my former 350W PSU had 170W output power=
=2E
And I never had any trouble with this setup before.
Moreover my system worked fine with ADMA disabled -> you can switch off=
 ADMA with bootparam "sata_nv.adma=3D0" in grub.
So I really thought the drive or some bug caused my problem.

But now I got the chance to try out a new PSU 550W Seasonic.

With the new PSU I don't get the reset errors anymore and my box stoppe=
d freezing, my System works fine for 2 weeks now.
It seems like NFORCE4 in ADMA Mode is very sensitive if there are power=
 issues.

Cheers=20


----- Urspr=FCngliche Mail ----
Von: Jens Pr=FCfer <jens.pruefer@gmx.de>
An: jgarzik@pobox.com
CC: linux-ide@vger.kernel.org
Gesendet: Mittwoch, den 24. Oktober 2007, 20:33:53 Uhr
Betreff: Possible NCQ problem with Seagate ST3250620NS/nForce 4

Hi,

I am experiencing reproducible timeout problems when using NCQ-enabled=20
kernels (tried various Debian and Ubuntu kernels as well as vanilla=20
2.6.23.1. It runs ok for a few minutes, but the first time there is any
=20
real load on the drive, it freezes (heaps of timeouts) until NCQ gets=20
switched off.

--- snip ---

[  202.616000] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0=20
gen_ctl 0x1501000 status 0x400 next cpb count 0x4 next cpb idx 0x0
[  202.616000] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x0
[  202.616000] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
[  202.616000] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
[  202.616000] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
[  202.616000] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
[  202.616000] ata1: timeout waiting for ADMA IDLE, stat=3D0x400
[  202.616000] ata1: timeout waiting for ADMA LEGACY, stat=3D0x400
[  202.616000] ata1.00: exception Emask 0x0 SAct 0x1f SErr 0x0 action
 0x2=20
frozen
[  202.616000] ata1.00: cmd 61/00:00:b5:d1:28/02:00:17:00:00/40 tag 0
 cdb=20
0x0 data 262144 out
[  202.616000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
 0x4=20
(timeout)
[  202.616000] ata1.00: cmd 61/78:08:b5:d3:28/01:00:17:00:00/40 tag 1
 cdb=20
0x0 data 192512 out
[  202.616000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
 0x4=20
(timeout)
[  202.616000] ata1.00: cmd 61/08:10:a5:45:27/00:00:17:00:00/40 tag 2
 cdb=20
0x0 data 4096 out
[  202.616000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
 0x4=20
(timeout)
[  202.616000] ata1.00: cmd 60/10:18:15:4e:b9/00:00:1a:00:00/40 tag 3
 cdb=20
0x0 data 8192 in
[  202.616000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
 0x4=20
(timeout)
[  202.616000] ata1.00: cmd 60/08:20:25:4a:df/00:00:1a:00:00/40 tag 4
 cdb=20
0x0 data 4096 in
[  202.616000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
 0x4=20
(timeout)
[  202.932000] ata1: soft resetting port
[  203.088000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  203.248000] ata1.00: configured for UDMA/133
[  203.248000] ata1: EH complete
[  203.248000] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors
 (250059=20
MB)
[  203.248000] sd 0:0:0:0: [sda] Write Protect is off
[  203.248000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  203.252000] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
 enabled,=20
doesn't support DPO or FUA
[  233.248000] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0=20
gen_ctl 0x1501000 status 0x400 next cpb count 0x4 next cpb idx 0x0
[  233.248000] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x0
[  233.248000] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
[  233.248000] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
[  233.248000] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
[  233.248000] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
[  233.248000] ata1: timeout waiting for ADMA IDLE, stat=3D0x400
[  233.248000] ata1: timeout waiting for ADMA LEGACY, stat=3D0x400
[  233.248000] ata1.00: NCQ disabled due to excessive errors

--- snap ---

The device is a Seagate ST3250620NS. Maybe it should be blacklisted as
 well?

Anyhow, I cannot find any boot parameter to switch off NCQ and
 circumvent=20
the freezing of the drive. Something like the "noacpi" option (maybe=20
noncq?) would be nice. Or am I missing something?

Cheers,

Jens Pr=FCfer
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html





      Jetzt Mails schnell in einem Vorschaufenster =FCberfliegen. Dies =
und viel mehr bietet das neue Yahoo! Mail - www.yahoo.de/mail
