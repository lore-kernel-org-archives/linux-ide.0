From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Mon, 17 Mar 2008 20:15:13 -0400
Message-ID: <20080318001513.GA2389@denix.org>
References: <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com>
 <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com>
 <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com>
 <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com>
 <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:48508 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYCRAPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 20:15:35 -0400
Received: from gandalf.denix.org ([71.126.191.34]) by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JXW00J7JGKNS6SF@vms173003.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 17 Mar 2008 19:12:24 -0500 (CDT)
In-reply-to: <47DDE0ED.6040304@rtr.ca>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

On Sun, Mar 16, 2008 at 11:09:33PM -0400, Mark Lord wrote:
> Denys Dmytriyenko wrote:
>>
>> 1. Keep existing system, but utilize 2 PCI-X slots for SATA controllers. 
>> This requires using 8-port adapters, like the one I already have 
>> Supermicro Marvell based. The question is - how stable sata_mv these days? 
>> It still says HIGHLY EXPERIMENTAL...
> ..
>
> It will lose that status early in the 2.6.26 timeframe.
>
> Currently it does seem to work reasonably, with NCQ even,
> but there are still errata for me to get round to fixing,
> and the IRQ/EH/Reset code needs some work to ensure it can
> always recover when something weird happens.
>
> Port multiplier support is working now, and will be pushed
> for 2.6.26 along with other fixes and stuff.
>
> ATAPI support may yet follow before the summer.

Thanks for the update.

Meanwhile my system was quite stable lately, except for a few times when it 
threw some exceptions below. Can you please help me interpret them and also 
point out to how I can do it myself in the future. Thanks in advance.

Mar  8 02:09:49 [kernel] ata8: illegal qc_active transition (00000019->00000038)
Mar  8 02:09:49 [kernel] ata8.00: exception Emask 0x2 SAct 0x19 SErr 0x0 action 0x2 frozen
Mar  8 02:09:49 [kernel] ata8.00: cmd 60/08:00:87:77:62/00:00:0c:00:00/40 tag 0 cdb 0x0 data 4096 in
Mar  8 02:09:49 [kernel]          res 50/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar  8 02:09:49 [kernel] ata8.00: cmd 60/08:18:97:77:62/00:00:0c:00:00/40 tag 3 cdb 0x0 data 4096 in
Mar  8 02:09:49 [kernel]          res 50/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar  8 02:09:49 [kernel] ata8.00: cmd 60/08:20:a7:77:62/00:00:0c:00:00/40 tag 4 cdb 0x0 data 4096 in
Mar  8 02:09:49 [kernel]          res 50/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar  8 02:09:50 [kernel] ata8: soft resetting port
Mar  8 02:09:50 [kernel] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  8 02:09:50 [kernel] ata8.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (976773168)
Mar  8 02:09:50 [kernel] ata8.00: configured for UDMA/100
Mar  8 02:09:50 [kernel] ata8: EH pending after completion, repeating EH (cnt=4)
Mar  8 02:09:50 [kernel] ata8: soft resetting port
Mar  8 02:09:50 [kernel] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  8 02:09:50 [kernel] ata8.00: configured for UDMA/100
Mar  8 02:09:50 [kernel] ata8: EH complete
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Write Protect is off
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Write Protect is off
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Mar  8 02:09:50 [kernel] sd 7:0:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA



Mar  8 03:19:33 [kernel] ata8: illegal qc_active transition (000000ff->000001f7)
Mar  8 03:19:33 [kernel] ata8.00: exception Emask 0x2 SAct 0xff SErr 0x0 action 0x2 frozen
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:00:3f:60:51/00:00:18:00:00/40 tag 0 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:08:47:60:51/00:00:18:00:00/40 tag 1 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:10:57:60:51/00:00:18:00:00/40 tag 2 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:18:9f:60:51/00:00:18:00:00/40 tag 3 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/18:20:67:60:51/00:00:18:00:00/40 tag 4 cdb 0x0 data 12288 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:28:87:60:51/00:00:18:00:00/40 tag 5 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/08:30:97:60:51/00:00:18:00:00/40 tag 6 cdb 0x0 data 4096 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8.00: cmd 60/10:38:a7:60:51/00:00:18:00:00/40 tag 7 cdb 0x0 data 8192 in
Mar  8 03:19:33 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x2 (HSM violation)
Mar  8 03:19:33 [kernel] ata8: soft resetting port
Mar  8 03:19:34 [kernel] ata8: softreset failed (port not ready)
Mar  8 03:19:34 [kernel] ata8: reset failed (errno=-5), retrying in 10 secs
Mar  8 03:19:43 [kernel] ata8: hard resetting port
Mar  8 03:19:46 [kernel] ata8: softreset failed (SRST command error)
Mar  8 03:19:46 [kernel] ata8: reset failed (errno=-5), retrying in 8 secs
Mar  8 03:19:53 [kernel] ata8: hard resetting port
Mar  8 03:19:56 [kernel] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  8 03:19:56 [kernel] ata8.00: configured for UDMA/100
Mar  8 03:19:56 [kernel] ata8: EH complete
Mar  8 03:19:56 [kernel] sd 7:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
Mar  8 03:19:56 [kernel] sd 7:0:0:0: [sdf] Write Protect is off
Mar  8 03:19:56 [kernel] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Mar  8 03:19:56 [kernel] sd 7:0:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA



Mar 14 23:51:43 [kernel] ata3: illegal qc_active transition (0000001b->0000002b)
Mar 14 23:51:43 [kernel] ata3.00: exception Emask 0x2 SAct 0x1b SErr 0x0 action 0x6 frozen
Mar 14 23:51:43 [kernel] ata3.00: cmd 60/08:00:3f:af:a9/00:00:05:00:00/40 tag 0 cdb 0x0 data 4096 in
Mar 14 23:51:43 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar 14 23:51:43 [kernel] ata3.00: cmd 60/20:08:7f:af:a9/00:00:05:00:00/40 tag 1 cdb 0x0 data 16384 in
Mar 14 23:51:43 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar 14 23:51:43 [kernel] ata3.00: cmd 60/08:18:4f:af:a9/00:00:05:00:00/40 tag 3 cdb 0x0 data 4096 in
Mar 14 23:51:43 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar 14 23:51:43 [kernel] ata3.00: cmd 60/08:20:5f:af:a9/00:00:05:00:00/40 tag 4 cdb 0x0 data 4096 in
Mar 14 23:51:43 [kernel]          res 50/00:00:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
Mar 14 23:51:43 [kernel] ata3: hard resetting port
Mar 14 23:51:45 [kernel] ata3: softreset failed (SRST command error)
Mar 14 23:51:45 [kernel] ata3: reset failed (errno=-5), retrying in 8 secs
Mar 14 23:51:53 [kernel] ata3: hard resetting port
Mar 14 23:51:55 [kernel] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 14 23:51:55 [kernel] ata3.00: configured for UDMA/100
Mar 14 23:51:55 [kernel] ata3: EH complete
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Write Protect is off
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA



Mar 14 23:51:55 [kernel] ata3: failed to read log page 10h (errno=-2)
Mar 14 23:51:55 [kernel] ata3.00: exception Emask 0x1 SAct 0x3f SErr 0x0 action 0x0
Mar 14 23:51:55 [kernel] ata3.00: irq_stat 0x00020002, device error via SDB FIS
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/08:00:5f:af:a9/00:00:05:00:00/40 tag 0 cdb 0x0 data 4096 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/08:08:4f:af:a9/00:00:05:00:00/40 tag 1 cdb 0x0 data 4096 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/20:10:7f:af:a9/00:00:05:00:00/40 tag 2 cdb 0x0 data 16384 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/08:18:3f:af:a9/00:00:05:00:00/40 tag 3 cdb 0x0 data 4096 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/30:20:9f:af:a9/00:00:05:00:00/40 tag 4 cdb 0x0 data 24576 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: cmd 60/30:28:cf:af:a9/00:00:05:00:00/40 tag 5 cdb 0x0 data 24576 in
Mar 14 23:51:55 [kernel]          res 50/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
Mar 14 23:51:55 [kernel] ata3.00: configured for UDMA/100
Mar 14 23:51:55 [kernel] ata3: EH complete
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Write Protect is off
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Mar 14 23:51:55 [kernel] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Regards,
Denys
