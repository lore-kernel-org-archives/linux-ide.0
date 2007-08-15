From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: regression problem with Maxtor disk
Date: Wed, 15 Aug 2007 17:31:00 -0600
Message-ID: <46C38CB4.5000104@shaw.ca>
References: <87tzr4zvpt.fsf@wyrd.be> <46C17AE0.5090601@gmail.com>
 <46C23746.6030203@shaw.ca> <878x8dl07z.fsf@wyrd.be>
 <46C2B0FD.5030101@gmail.com> <87wsvw8pda.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49716 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762852AbXHOXbe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 19:31:34 -0400
Received: from pd2mr1so.prod.shaw.ca
 (pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMU00FIY9C9ZFE0@l-daemon> for linux-ide@vger.kernel.org; Wed,
 15 Aug 2007 17:31:21 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
 by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JMU008GO9C4DG70@pd2mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 15 Aug 2007 17:31:21 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMU00HM89C3MWK1@l-daemon> for linux-ide@vger.kernel.org; Wed,
 15 Aug 2007 17:31:16 -0600 (MDT)
In-reply-to: <87wsvw8pda.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lieven Marchand <mal@wyrd.be>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Lieven Marchand wrote:
> Tejun Heo <htejun@gmail.com> writes:
> 
>> It seems klogd clipped some messages.  Can you please turn on printk
>> timestamp, enlarge printk log buffersize and post the result of 'dmesg'
>> after errors?
> 
> [   34.576963] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   34.586151] ata1.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
> [   34.586191] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [   34.602085] ata1.00: configured for UDMA/133

..

> [   48.994556] ata1: timeout waiting for ADMA IDLE, stat=0x440
> [   49.147577] ata1: failed to read log page 10h (errno=-2)
> [   49.149046] ata1.00: exception Emask 0x1 SAct 0xff SErr 0x0 action 0x0
> [   49.149086] ata1.00: (CPB resp_flags 0x11: CMD error)
> [   49.149129] ata1.00: cmd 61/06:00:bc:bf:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 3072 out
> [   49.149131]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149234] ata1.00: cmd 61/04:08:c4:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
> [   49.149236]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149338] ata1.00: cmd 61/02:10:d6:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
> [   49.149340]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149443] ata1.00: cmd 61/04:18:dc:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 2048 out
> [   49.149445]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149547] ata1.00: cmd 61/02:20:e8:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 1024 out
> [   49.149549]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149652] ata1.00: cmd 61/02:28:f2:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
> [   49.149653]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149756] ata1.00: cmd 61/04:30:fa:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
> [   49.149758]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.149860] ata1.00: cmd 61/02:38:04:c0:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 1024 out
> [   49.149862]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
> [   49.175045] ata1.00: configured for UDMA/133
> [   49.175095] ata1: EH complete
> [   49.175145] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x440
> [   49.175237] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [   49.175285] sd 0:0:0:0: [sda] Write Protect is off
> [   49.175323] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   49.175334] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

I'm not sure exactly what the controller asserting CMD error on the CPB 
means (I don't think either Jeff or NVIDIA ever let out that particular 
bit of info), but presumably some kind of FIS error. It seems like the 
drive is not responding after this point, everything times out. Likely 
model "Maxtor 7H500F0" and firmware "HA431DN0" needs to be added to the 
NCQ blacklist. I think this is a similar symptom to some other Maxtor 
disks which seem to wedge up when NCQ is used..

> [   79.155040] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x17 next cpb idx 0x0
> [   79.155098] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
> [   79.155136] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
> [   79.155174] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
> [   79.155212] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
> [   79.155250] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
> [   79.155288] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
> [   79.155326] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
> [   79.155364] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
> [   79.155402] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
> [   79.155440] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
> [   79.155478] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
> [   79.155517] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
> [   79.155555] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
> [   79.155593] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
> [   79.155631] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
> [   79.155669] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
> [   79.155708] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
> [   79.155746] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
> [   79.155784] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
> [   79.155828] ata1: timeout waiting for ADMA IDLE, stat=0x400
> [   79.155873] ata1: timeout waiting for ADMA LEGACY, stat=0x400
> [   79.155917] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
> [   79.155971] ata1.00: cmd 61/02:00:02:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 1024 out
> [   79.155973]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156075] ata1.00: cmd 61/04:08:fa:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
> [   79.156077]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156179] ata1.00: cmd 61/02:10:f2:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
> [   79.156180]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156282] ata1.00: cmd 61/02:18:e8:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 1024 out
> [   79.156284]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156386] ata1.00: cmd 61/04:20:dc:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 2048 out
> [   79.156388]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156490] ata1.00: cmd 61/02:28:d6:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
> [   79.156492]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156594] ata1.00: cmd 61/04:30:c4:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
> [   79.156596]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156698] ata1.00: cmd 61/06:38:bc:bf:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 3072 out
> [   79.156699]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [   79.156801] ata1.00: cmd 61/04:40:08:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 2048 out
> [   79.156803]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.156905] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
> [   79.156907]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157009] ata1.00: cmd 61/06:50:d0:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 3072 out
> [   79.157011]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157113] ata1.00: cmd 61/02:58:d8:c0:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 1024 out
> [   79.157114]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157216] ata1.00: cmd 61/02:60:e0:c0:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 1024 out
> [   79.157218]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157320] ata1.00: cmd 61/02:68:f0:c0:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
> [   79.157322]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157424] ata1.00: cmd 61/02:70:f8:c0:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 1024 out
> [   79.157426]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157528] ata1.00: cmd 61/04:78:fc:c0:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 2048 out
> [   79.157529]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157631] ata1.00: cmd 61/02:80:06:c1:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
> [   79.157633]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157735] ata1.00: cmd 61/06:88:0a:c1:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 3072 out
> [   79.157737]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.157839] ata1.00: cmd 61/04:90:18:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 2048 out
> [   79.157841]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [   79.466629] ata1: soft resetting port
> [   79.622437] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   79.647445] ata1.00: configured for UDMA/133
> [   79.647494] ata1: EH complete
> [   79.647538] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
> [   79.647602] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [   79.647648] sd 0:0:0:0: [sda] Write Protect is off
> [   79.647686] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   79.647697] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  109.607481] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x12 next cpb idx 0x0
> [  109.607538] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
> [  109.607576] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
> [  109.607614] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
> [  109.607652] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
> [  109.607690] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
> [  109.607728] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
> [  109.607766] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
> [  109.607804] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
> [  109.607842] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
> [  109.607880] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
> [  109.607919] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
> [  109.607957] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
> [  109.607995] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
> [  109.608033] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
> [  109.608071] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
> [  109.608110] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
> [  109.608148] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
> [  109.608186] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
> [  109.608224] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
> [  109.608268] ata1: timeout waiting for ADMA IDLE, stat=0x400
> [  109.608313] ata1: timeout waiting for ADMA LEGACY, stat=0x400
> [  109.608356] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
> [  109.608410] ata1.00: cmd 61/04:00:18:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 2048 out
> [  109.608412]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.609937] ata1.00: cmd 61/06:08:0a:c1:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 3072 out
> [  109.609938]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610041] ata1.00: cmd 61/02:10:06:c1:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
> [  109.610042]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610145] ata1.00: cmd 61/04:18:fc:c0:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 2048 out
> [  109.610146]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610249] ata1.00: cmd 61/02:20:f8:c0:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 1024 out
> [  109.610250]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610353] ata1.00: cmd 61/02:28:f0:c0:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
> [  109.610354]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610456] ata1.00: cmd 61/02:30:e0:c0:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 1024 out
> [  109.610458]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610560] ata1.00: cmd 61/02:38:d8:c0:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 1024 out
> [  109.610562]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  109.610664] ata1.00: cmd 61/06:40:d0:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 3072 out
> [  109.610666]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.610768] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
> [  109.610769]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.610871] ata1.00: cmd 61/04:50:08:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 2048 out
> [  109.610873]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.610975] ata1.00: cmd 61/06:58:bc:bf:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 3072 out
> [  109.610977]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611079] ata1.00: cmd 61/04:60:c4:bf:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 2048 out
> [  109.611081]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611183] ata1.00: cmd 61/02:68:d6:bf:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
> [  109.611185]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611287] ata1.00: cmd 61/04:70:dc:bf:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 2048 out
> [  109.611288]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611391] ata1.00: cmd 61/02:78:e8:bf:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 1024 out
> [  109.611392]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611497] ata1.00: cmd 61/02:80:f2:bf:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
> [  109.611498]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611601] ata1.00: cmd 61/04:88:fa:bf:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 2048 out
> [  109.611602]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.611704] ata1.00: cmd 61/02:90:02:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 1024 out
> [  109.611706]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  109.923055] ata1: soft resetting port
> [  110.078863] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  110.104389] ata1.00: configured for UDMA/133
> [  110.104437] ata1: EH complete
> [  110.104480] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
> [  110.104543] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [  110.104588] sd 0:0:0:0: [sda] Write Protect is off
> [  110.104625] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [  110.104636] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  140.063908] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x12 next cpb idx 0x0
> [  140.063965] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
> [  140.064003] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
> [  140.064041] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
> [  140.064079] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
> [  140.064117] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
> [  140.064156] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
> [  140.064194] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
> [  140.064232] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
> [  140.064270] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
> [  140.064308] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
> [  140.064346] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
> [  140.064384] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
> [  140.064422] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
> [  140.064460] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
> [  140.064498] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
> [  140.064537] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
> [  140.064575] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
> [  140.064613] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
> [  140.064651] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
> [  140.064695] ata1: timeout waiting for ADMA IDLE, stat=0x400
> [  140.064740] ata1: timeout waiting for ADMA LEGACY, stat=0x400
> [  140.064782] ata1.00: NCQ disabled due to excessive errors
> [  140.064821] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
> [  140.064875] ata1.00: cmd 61/02:00:02:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 1024 out
> [  140.064877]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.064979] ata1.00: cmd 61/04:08:fa:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
> [  140.064981]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065083] ata1.00: cmd 61/02:10:f2:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
> [  140.065085]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065187] ata1.00: cmd 61/02:18:e8:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 1024 out
> [  140.065188]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065290] ata1.00: cmd 61/04:20:dc:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 2048 out
> [  140.065292]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065394] ata1.00: cmd 61/02:28:d6:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
> [  140.065396]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065498] ata1.00: cmd 61/04:30:c4:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
> [  140.065500]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065602] ata1.00: cmd 61/06:38:bc:bf:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 3072 out
> [  140.065603]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  140.065705] ata1.00: cmd 61/04:40:08:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 2048 out
> [  140.065707]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.065809] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
> [  140.065810]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.065912] ata1.00: cmd 61/06:50:d0:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 3072 out
> [  140.065914]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066016] ata1.00: cmd 61/02:58:d8:c0:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 1024 out
> [  140.066018]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066120] ata1.00: cmd 61/02:60:e0:c0:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 1024 out
> [  140.066121]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066224] ata1.00: cmd 61/02:68:f0:c0:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
> [  140.066225]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066327] ata1.00: cmd 61/02:70:f8:c0:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 1024 out
> [  140.066329]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066431] ata1.00: cmd 61/04:78:fc:c0:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 2048 out
> [  140.066433]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066535] ata1.00: cmd 61/02:80:06:c1:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
> [  140.066537]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066639] ata1.00: cmd 61/06:88:0a:c1:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 3072 out
> [  140.066641]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.066743] ata1.00: cmd 61/04:90:18:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 2048 out
> [  140.066744]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> [  140.379482] ata1: soft resetting port
> [  140.535289] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  140.560308] ata1.00: configured for UDMA/133
> [  140.560356] ata1: EH complete
> [  140.560400] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
> [  170.520332] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x0 next cpb idx 0x0
> [  170.520389] ata1: CPB 0: ctl_flags 0xd, resp_flags 0x0
> [  170.520433] ata1: timeout waiting for ADMA IDLE, stat=0x400
> [  170.520477] ata1: timeout waiting for ADMA LEGACY, stat=0x400
> [  170.520521] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  170.520565] ata1.00: cmd 35/00:04:18:c1:df/00:00:16:00:00/e0 tag 0 cdb 0x0 data 2048 out
> [  170.520567]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
> [  170.831913] ata1: soft resetting port
> [  170.987721] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  171.012723] ata1.00: configured for UDMA/133
> [  171.012762] ata1: EH complete
> [  171.162056] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [  171.166591] sd 0:0:0:0: [sda] Write Protect is off
> [  171.166629] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [  171.178390] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  171.195572] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [  171.204351] sd 0:0:0:0: [sda] Write Protect is off
> [  171.204389] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [  171.214556] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> 
