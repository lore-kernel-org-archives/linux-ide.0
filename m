From: Tim Small <tim@buttersideup.com>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Mon, 08 Feb 2010 13:03:15 +0000
Message-ID: <4B700B93.6030006@buttersideup.com>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com> <4B6C91F3.5090809@teksavvy.com> <4B6CE473.7060901@kernel.org> <4B6D8A12.70200@buttersideup.com> <4B6DA74C.2040007@teksavvy.com> <4B6DEBA7.2030505@buttersideup.com> <4B6E46DA.9040308@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:40952 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0BHNDc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 08:03:32 -0500
In-Reply-To: <4B6E46DA.9040308@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>

Mark Lord wrote:
> Tim Small wrote:
>> Mark Lord wrote:
>>> My theory on the problem when I first had it here, was that doing
>>> a FLUSH_CACHE[_EXT] before any PIO command (eg. SMART) should prevent
>>> the problem.  This was never explored further (by me or others).
>>>
>>
>> Would using "option libata force=pio4" be a simple way to start to test
>> this hypothesis?
> ..
>
> Yup.  If the hypothesis is FALSE, then you'll still see trouble.
> Otherwise, it *might* be correct.  ;)

It looks like it is false then....

[59745.632984] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[59745.633036] ata1.01: cmd 34/00:00:87:c6:f7/00:04:00:00:00/f0 tag 0 
pio 524288 out
[59745.633086] ata1.01: status: { DRDY }
[59745.633117] ata1: soft resetting link
[59747.094498] ata1.00: FORCE: xfer_mask set to pio4
[59747.094498] ata1.01: FORCE: xfer_mask set to pio4
[59747.102353] ata1.00: configured for PIO4
[59747.108610] ata1.01: configured for PIO4
[59747.108610] ata1: EH complete
[59747.437125] sd 0:0:0:0: [sda] 3907029168 512-byte hardware sectors 
(2000399 MB)
[59747.499739] sd 0:0:0:0: [sda] Write Protect is off
[59747.499739] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[59747.844755] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[59748.047834] sd 0:0:1:0: [sdb] 3907029168 512-byte hardware sectors 
(2000399 MB)
...


7 14:20:32: [101181.209812] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
7 14:20:32: [101181.209865] ata1.01: cmd 
34/00:00:0f:4d:f0/00:04:00:00:00/f0 tag 0 pio 524288 out
7 14:20:32: [101181.209909] ata1.01: status: { DRDY }
7 14:20:32: [101181.209946] ata1: soft resetting link
--
7 15:54:12: [110247.451925] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
7 15:54:12: [110247.451979] ata1.01: cmd 
34/00:00:bf:8e:e8/00:04:00:00:00/f0 tag 0 pio 524288 out
7 15:54:12: [110247.452028] ata1.01: status: { DRDY }
7 15:54:12: [110247.452062] ata1: soft resetting link
--
7 23:47:13: [155689.544839] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
7 23:47:13: [155689.544892] ata1.01: cmd 
34/00:00:d7:0f:fe/00:04:00:00:00/f0 tag 0 pio 524288 out
7 23:47:13: [155689.544935] ata1.01: status: { DRDY }
7 23:47:13: [155689.544974] ata1: soft resetting link
--
8 00:59:30: [162616.848048] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 00:59:30: [162616.848099] ata1.01: cmd 
34/00:00:5f:6b:e9/00:04:00:00:00/f0 tag 0 pio 524288 out
8 00:59:30: [162616.848143] ata1.01: status: { DRDY }
8 00:59:30: [162616.848175] ata1: soft resetting link
--
8 01:01:22: [162789.662299] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 01:01:22: [162789.662338] ata1.01: cmd 
34/00:00:5f:6c:ed/00:04:00:00:00/f0 tag 0 pio 524288 out
8 01:01:22: [162789.662381] ata1.01: status: { DRDY }
8 01:01:22: [162789.662418] ata1: soft resetting link
--
8 01:14:43: [164059.753030] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 01:14:43: [164059.753082] ata1.01: cmd 
ec/00:00:00:00:00/00:00:00:00:00/10 tag 0 pio 512 in
8 01:14:43: [164059.753129] ata1.01: status: { DRDY }
8 01:14:48: [164067.298313] ata1: link is slow to respond, please be 
patient (ready=0)
--
8 01:56:33: [168105.660062] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 01:56:33: [168105.660115] ata1.01: cmd 
34/00:00:0f:2f:e6/00:04:00:00:00/f0 tag 0 pio 524288 out
8 01:56:33: [168105.660164] ata1.01: status: { DRDY }
8 01:56:33: [168105.660193] ata1: soft resetting link
--
8 02:11:42: [169562.773251] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 02:11:42: [169562.773303] ata1.01: cmd 
34/00:00:87:8c:ef/00:04:00:00:00/f0 tag 0 pio 524288 out
8 02:11:42: [169562.773352] ata1.01: status: { DRDY }
8 02:11:42: [169562.773386] ata1: soft resetting link
--
8 04:35:16: [183417.972749] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 04:35:16: [183417.972749] ata1.01: cmd 
34/00:40:a7:7f:fc/00:01:00:00:00/f0 tag 0 pio 163840 out
8 04:35:16: [183417.972749] ata1.01: status: { DRDY }
8 04:35:16: [183417.972749] ata1: soft resetting link
--
8 07:11:47: [198460.847454] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 07:11:47: [198460.847507] ata1.01: cmd 
34/00:00:67:2c:ef/00:04:00:00:00/f0 tag 0 pio 524288 out
8 07:11:47: [198460.847555] ata1.01: status: { DRDY }
8 07:11:47: [198460.847583] ata1: soft resetting link
--
8 07:40:48: [201232.970903] ata1.01: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x6 frozen
8 07:40:48: [201232.970903] ata1.01: cmd 
34/00:00:c7:2d:e5/00:04:00:00:00/f0 tag 0 pio 524288 out
8 07:40:48: [201232.970903] ata1.01: status: { DRDY }
8 07:40:48: [201232.970903] ata1: soft resetting link

... but, it turns out that I have another box at home which I've been 
able to provoke into doing similar things:

16:46:49: [1130032.307185] ata1.00: exception Emask 0x10 SAct 0x0 SErr 
0x4000000 action 0xe frozen
16:46:49: [1130032.307197] ata1.00: irq_stat 0x00000040, connection 
status changed
16:46:49: [1130032.307200] ata1: SError: { DevExch }
16:46:49: [1130032.307205] ata1.00: cmd 
b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
16:46:49: [1130032.307207]          res 
40/00:4c:1f:fa:9a/00:00:06:00:00/40 Emask 0x10 (ATA bus error)
16:46:49: [1130032.307210] ata1.00: status: { DRDY }
16:46:49: [1130032.307219] ata1: hard resetting link
16:46:55: [1130038.083028] ata1: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
16:47:25: [1130068.090133] ata1.00: qc timeout (cmd 0xec)
16:47:25: [1130068.090148] ata1.00: failed to IDENTIFY (I/O error, 
err_mask=0x5)
16:47:25: [1130068.090152] ata1.00: revalidation failed (errno=-5)
16:47:25: [1130068.090156] ata1: failed to recover some devices, 
retrying in 5 secs
16:47:30: [1130073.094116] ata1: hard resetting link
16:47:30: [1130073.414133] ata1: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
16:47:30: [1130073.436396] ata1.00: configured for UDMA/133
16:47:30: [1130073.436396] ata1: EH complete
16:47:30: [1130073.436396] sd 0:0:0:0: [sda] 976773168 512-byte hardware 
sectors (500108 MB)
16:47:30: [1130073.436396] sd 0:0:0:0: [sda] Write Protect is off
16:47:30: [1130073.436396] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00

17:21:21: [1132149.195367] ata1.00: exception Emask 0x10 SAct 0x0 SErr 
0x4040000 action 0xe frozen
17:21:21: [1132149.195378] ata1.00: irq_stat 0x00000040, connection 
status changed
17:21:21: [1132149.195384] ata1: SError: { CommWake DevExch }
17:21:21: [1132149.195394] ata1.00: cmd 
b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
17:21:21: [1132149.195397]          res 
40/00:2c:77:ad:63/00:00:06:00:00/40 Emask 0x10 (ATA bus error)
17:21:21: [1132149.195403] ata1.00: status: { DRDY }
--
18:28:29: [1136257.076898] ata1.00: exception Emask 0x0 SAct 0x7fffffff 
SErr 0x0 action 0x6 frozen
18:28:29: [1136257.076898] ata1.00: cmd 
61/00:00:27:b5:89/04:00:06:00:00/40 tag 0 ncq 524288 out
18:28:29: [1136257.076898]          res 
40/00:f4:27:b1:89/00:00:06:00:00/40 Emask 0x4 (timeout)
18:28:29: [1136257.076898] ata1.00: status: { DRDY }
18:28:29: [1136257.076898] ata1.00: cmd 
61/00:08:27:b9:89/04:00:06:00:00/40 tag 1 ncq 524288 out
18:28:29: [1136257.076898]          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
--
18:53:19: [1137768.517637] ata1.00: exception Emask 0x10 SAct 0x0 SErr 
0x4040000 action 0xe frozen
18:53:19: [1137768.517637] ata1.00: irq_stat 0x00000040, connection 
status changed
18:53:19: [1137768.517637] ata1: SError: { CommWake DevExch }
18:53:19: [1137768.517637] ata1.00: cmd 
b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
18:53:19: [1137768.517637]          res 
40/00:0c:7b:99:09/00:00:02:00:00/40 Emask 0x10 (ATA bus error)
18:53:19: [1137768.517637] ata1.00: status: { DRDY }


This also has an ICH7, but it's in AHCI mode, so ata_piix would seem to 
be off the hook in this case.

I have a couple of other SATA controllers in that box (JMicron 
20360/20363 and a SiI 3132), so I should be able to put the drive on 
those controllers instead to see if the same thing happens.  Annoyingly 
(but only from the PoV of that issue), I'm about to go on holiday, but 
I'll try and do this before I go....

Cheers,

Tim.
