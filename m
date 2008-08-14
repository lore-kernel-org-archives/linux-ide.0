From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 20:17:08 +0700
Message-ID: <48A43054.80605@ngs.ru>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru> <48A36FE5.5000706@rtr.ca> <48A3E1FF.4030502@ngs.ru> <48A427C0.1070500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:47114 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYHNNRB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Aug 2008 09:17:01 -0400
In-Reply-To: <48A427C0.1070500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Now I spend ~1.9 seconds to serve one bad sector. That's great.
0.75 of 1.9 seconds is a time spent on hard reset, 1.15 seconds are=20
spent on reallocation try.
Is hard reset real necessary to return disk to life after media error?



time dd if=3D/dev/sda of=3D/dev/null count=3D1 skip=3D300000
dd: reading `/dev/sda': Input/output error
0+0 records in
0+0 records out
0 bytes (0 B) copied, 1.87432 s, 0.0 kB/s

real    0m1.876s

[63107.038255] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x=
6
[63107.038287] ata6.00: edma_err_cause=3D00000084 pp_flags=3D00000003, =
dev=20
error, EDMA self-disable
[63107.038335] ata6.00: cmd 60/08:00:e0:93:04/00:00:00:00:00/40 tag 0=20
ncq 4096 in
[63107.038336]          res 51/40:08:e0:93:04/01:00:00:00:00/00 Emask=20
0x409 (media error) <F>
[63107.038380] ata6.00: status: { DRDY ERR }
[63107.038403] ata6.00: error: { UNC }
[63107.038430] ata6: hard resetting link
[63107.608304] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[63107.692432] ata6.00: max_sectors limited to 256 for NCQ
[63107.772479] ata6.00: max_sectors limited to 256 for NCQ
[63107.772481] ata6.00: configured for UDMA/133
[63107.772488] sd 5:0:0:0: [sda] Result: hostbyte=3DDID_OK=20
driverbyte=3DDRIVER_SENSE,SUGGEST_OK
[63107.772491] sd 5:0:0:0: [sda] Sense Key : Medium Error [current]=20
[descriptor]
[63107.772495] Descriptor sense data with sense descriptors (in hex):
[63107.772497]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
[63107.772504]         00 04 93 e0
[63107.772507] sd 5:0:0:0: [sda] Add. Sense: Unrecovered read error -=20
auto reallocate failed
[63107.772512] end_request: I/O error, dev sda, sector 300000
[63107.772540] Buffer I/O error on device sda, logical block 37500
[63107.772572] ata6: EH complete
[63107.790290] sd 5:0:0:0: [sda] 1465149168 512-byte hardware sectors=20
(750156 MB)
[63107.790290] sd 5:0:0:0: [sda] Write Protect is off
[63107.790290] sd 5:0:0:0: [sda] Mode Sense: 00 3a 00 00
[63107.790290] sd 5:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA




Mark Lord =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Artem Bokhan wrote:
> ..
>> IMHO, looks like cavity somewhere... Any ideas?
> ..
>
> Have you tried to disable fs read-ahead?
>
> Something like "hdparm -a0 /dev/sd*" ?
>
> -ml

