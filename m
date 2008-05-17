From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: Linux 2.6.24 sata_promise SATA300TX4 problems
Date: Sat, 17 May 2008 16:28:09 +0200
Message-ID: <482EEB79.90905@how.dk>
References: <479B0A39.2050700@how.dk>	<18331.53035.493189.308501@harpo.it.uu.se>	<479BD2E2.2060307@how.dk> <18331.59497.908868.283142@harpo.it.uu.se> <479CC044.8010401@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:34331 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYEQOxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 10:53:16 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id B46ABE391B
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 16:29:43 +0200 (CEST)
In-Reply-To: <479CC044.8010401@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi Mikael & list,

I have previously reported problems with my setup:

SATA300TX4 + 4 Seagate Barracuda ES 500GB

Just for the record: using the same setup with linux kernel 2.6.25.4 
shows the same problem running at 3.0gbps:

[  789.196047] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[  789.196057] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[  789.196066] ata1.00: cmd c8/00:00:00:0f:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[  789.196068]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  789.196072] ata1.00: status: { DRDY }
[  794.565999] ata1: port is slow to respond, please be patient (Status 
0xff)
[  799.245997] ata1: device not ready (errno=-16), forcing hardreset
[  799.246007] ata1: hard resetting link
[  805.456006] ata1: port is slow to respond, please be patient (Status 
0xff)
[  809.295996] ata1: COMRESET failed (errno=-16)
[  809.296006] ata1: hard resetting link
[  815.506040] ata1: port is slow to respond, please be patient (Status 
0xff)
[  819.346000] ata1: COMRESET failed (errno=-16)
[  819.346009] ata1: hard resetting link
[  825.555998] ata1: port is slow to respond, please be patient (Status 
0xff)
[  854.358881] ata1: COMRESET failed (errno=-16)
[  854.358894] ata1: limiting SATA link speed to 1.5 Gbps
[  854.358898] ata1: hard resetting link
[  859.368879] ata1: COMRESET failed (errno=-16)
[  859.368888] ata1: reset failed, giving up
[  859.368893] ata1.00: disabled
[  859.368910] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t4
[  859.368913] ata1: hotplug_status 0x80
[  859.368918] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[  859.368974] ata1: hard resetting link
[  865.978881] ata1: port is slow to respond, please be patient (Status 
0xff)
[  869.399061] ata1: COMRESET failed (errno=-16)
[  869.399071] ata1: hard resetting link
[  876.008881] ata1: port is slow to respond, please be patient (Status 
0xff)
[  879.428879] ata1: COMRESET failed (errno=-16)
[  879.428889] ata1: hard resetting link
[  886.038996] ata1: port is slow to respond, please be patient (Status 
0xff)
[  914.478964] ata1: COMRESET failed (errno=-16)
[  914.478977] ata1: limiting SATA link speed to 1.5 Gbps
[  914.478981] ata1: hard resetting link
[  919.528881] ata1: COMRESET failed (errno=-16)
[  919.528890] ata1: reset failed, giving up
[  919.528903] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t3
[  919.528906] ata1: hotplug_status 0x80
[  919.528911] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[  919.528970] ata1: hard resetting link
[  926.138988] ata1: port is slow to respond, please be patient (Status 
0xff)
[  929.559073] ata1: COMRESET failed (errno=-16)
[  929.559083] ata1: hard resetting link
[  936.168995] ata1: port is slow to respond, please be patient (Status 
0xff)
[  939.588874] ata1: COMRESET failed (errno=-16)
[  939.588884] ata1: hard resetting link
[  946.198886] ata1: port is slow to respond, please be patient (Status 
0xff)
[  974.638883] ata1: COMRESET failed (errno=-16)
[  974.638895] ata1: limiting SATA link speed to 1.5 Gbps
[  974.638898] ata1: hard resetting link
[  979.688879] ata1: COMRESET failed (errno=-16)
[  979.688890] ata1: reset failed, giving up
[  979.688909] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t2
[  979.688912] ata1: hotplug_status 0x80
[  979.688916] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[  979.688967] ata1: hard resetting link
[  986.298884] ata1: port is slow to respond, please be patient (Status 
0xff)
[  989.718881] ata1: COMRESET failed (errno=-16)
[  989.718891] ata1: hard resetting link
[  996.328887] ata1: port is slow to respond, please be patient (Status 
0xff)
[  999.748876] ata1: COMRESET failed (errno=-16)
[  999.748886] ata1: hard resetting link
[ 1006.358888] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1034.798882] ata1: COMRESET failed (errno=-16)
[ 1034.798894] ata1: limiting SATA link speed to 1.5 Gbps
[ 1034.798898] ata1: hard resetting link
[ 1039.848875] ata1: COMRESET failed (errno=-16)
[ 1039.848884] ata1: reset failed, giving up
[ 1039.848905] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t1
[ 1039.848908] ata1: hotplug_status 0x80
[ 1039.848912] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[ 1039.848969] ata1: hard resetting link
[ 1046.458878] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1049.878879] ata1: COMRESET failed (errno=-16)
[ 1049.878889] ata1: hard resetting link
[ 1056.488887] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1059.908881] ata1: COMRESET failed (errno=-16)
[ 1059.908891] ata1: hard resetting link
[ 1066.518879] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1094.958879] ata1: COMRESET failed (errno=-16)
[ 1094.958892] ata1: limiting SATA link speed to 1.5 Gbps
[ 1094.958896] ata1: hard resetting link
[ 1100.008876] ata1: COMRESET failed (errno=-16)
[ 1100.008885] ata1: reset failed, giving up
[ 1100.008891] ata1: EH pending after 5 tries, giving up
[ 1100.008909] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[ 1100.008913] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[ 1100.008918] Descriptor sense data with sense descriptors (in hex):
[ 1100.008921]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 1100.008928]         00 00 00 09
[ 1100.008931] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[ 1100.008934] end_request: I/O error, dev sda, sector 31854336
[ 1100.008939] Buffer I/O error on device sda, logical block 3981792
[ 1100.008944] Buffer I/O error on device sda, logical block 3981793
[ 1100.008948] Buffer I/O error on device sda, logical block 3981794
[ 1100.008951] Buffer I/O error on device sda, logical block 3981795
[ 1100.008955] Buffer I/O error on device sda, logical block 3981796
[ 1100.008958] Buffer I/O error on device sda, logical block 3981797
[ 1100.008961] Buffer I/O error on device sda, logical block 3981798
[ 1100.008964] Buffer I/O error on device sda, logical block 3981799
[ 1100.008967] Buffer I/O error on device sda, logical block 3981800
[ 1100.008970] Buffer I/O error on device sda, logical block 3981801
[ 1100.008990] sd 0:0:0:0: rejecting I/O to offline device
[ 1100.008998] ata1: EH complete
[ 1100.009008] ata1.00: detaching (SCSI 0:0:0:0)
[ 1100.009208] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1100.009509] sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
[ 1100.009514] end_request: I/O error, dev sda, sector 31854592
[ 1100.010478] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1100.010483] sd 0:0:0:0: [sda] Stopping disk
[ 1100.010492] sd 0:0:0:0: [sda] START_STOP FAILED
[ 1100.010495] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

Using Mikaels 1.5gbps patch produces no errors doing the same test.

Best regards,

Peter

Peter Favrholdt wrote:
> Hi Mikael,
> 
> Thanks!
> 
> It works perfectly at 1.5Gbps :-)
> 
> I think that because it fails at 3Gbps it might eventually fail at 
> 1.5Gbps also... And the error handling was not robust (in my setup with 
> these drives at 3Gbps).
> 
> If I can help investigate further, I'm happy to do that. I have a spare 
> controller card so I could try swapping them.  Do you have any 
> suggestions for what I should try next?
> 
> Best regards,
> 
> Peter
> 
> Mikael Pettersson wrote:
>> Peter Favrholdt writes:
>>  > If it is not too much of a hassle, could you please make a 1.5Gbps 
>> patch  > for 2.6.24 for me to try out? If it solves the problem 
>> (without me ever  > touching the cables) we know for sure it is 
>> speed-related and not due to  > kernel version.
>>
>> No problem. I had intended to drop that patch after 2.6.24-rc8 as it
>> ought to be obsolete, but then again it might not be. It's available 
>> here:
>> <http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-limit-sataii-to-1.5Gbps-2.6.24> 

