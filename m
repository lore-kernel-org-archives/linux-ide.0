From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Thu, 27 Nov 2008 00:07:13 +0100
Message-ID: <492DD6A1.8070907@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se> <49263F80.2060607@kernel.org> <492BF6FB.1050004@how.dk> <492CB89F.4010108@kernel.org> <492D0505.2030704@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:44828 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYKZXHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Nov 2008 18:07:19 -0500
In-Reply-To: <492D0505.2030704@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Hi Tejun and list,

Replying to my own mail, but now with the dmesg output which was missing 
earlier:

Peter Favrholdt wrote:
> Tejun Heo wrote:
>> Peter Favrholdt wrote:
>>> After running dd several times finally my setup failed. Unfortunately it
>>> didn't recover :-(
>>
>> Eh... crap.
>>
>>> Tejun Heo wrote:
>>>> sata_promise hardreset doesn't seem to be able to acquire the initial
>>>> D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
>>>> follow-up SRST.
>>>>
>>>>  http://article.gmane.org/gmane.linux.ide/36186
>>>>
>>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>>> ---
>>>> Peter, can you please test this one too?  It's essentially the same
>>>> code just slightly prettier.  Mikael, what do you think about this?
>>
>> Does unloading and reloading the driver make the device recognized
>> again?
> 
> Yes I tried modprobe -r sata_promise and modprobe sata_promise: It 
> didn't recognize the device. I forgot to post the dmesg output, sorry.

Well, ran the tests again and here is the errors from the new run:

[114851.970088] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[114851.970098] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[114851.970107] ata1.00: cmd 25/00:00:00:3f:e6/00:02:01:00:00/e0 tag 0 
dma 262144 in
[114851.970108]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[114851.970112] ata1.00: status: { DRDY }
[114851.970164] ata1: hard resetting link
[114857.520147] ata1: link is slow to respond, please be patient (ready=-19)
[114862.030032] ata1: SRST failed (errno=-16)
[114862.030121] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114867.050164] ata1.00: qc timeout (cmd 0xec)
[114867.050533] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[114867.050537] ata1.00: revalidation failed (errno=-5)
[114867.050560] ata1: hard resetting link
[114872.610029] ata1: link is slow to respond, please be patient (ready=-19)
[114877.111605] ata1: SRST failed (errno=-16)
[114877.111697] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114887.110131] ata1.00: qc timeout (cmd 0xec)
[114887.110457] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[114887.110461] ata1.00: revalidation failed (errno=-5)
[114887.110490] ata1: hard resetting link
[114892.660241] ata1: link is slow to respond, please be patient (ready=-19)
[114897.160046] ata1: SRST failed (errno=-16)
[114897.160148] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114927.160160] ata1.00: qc timeout (cmd 0xec)
[114927.160406] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[114927.160410] ata1.00: revalidation failed (errno=-5)
[114927.160413] ata1.00: disabled
[114927.160441] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t4
[114927.160444] ata1: hotplug_status 0x80
[114927.160487] ata1: hard resetting link
[114933.110040] ata1: link is slow to respond, please be patient (ready=-19)
[114937.190038] ata1: SRST failed (errno=-16)
[114937.190132] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114937.190179] ata1: link online but device misclassified, retrying
[114937.190227] ata1: hard resetting link
[114943.140073] ata1: link is slow to respond, please be patient (ready=-19)
[114947.220400] ata1: SRST failed (errno=-16)
[114947.220508] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114947.220542] ata1: link online but device misclassified, retrying
[114947.220576] ata1: hard resetting link
[114953.170035] ata1: link is slow to respond, please be patient (ready=-19)
[114982.280039] ata1: SRST failed (errno=-16)
[114982.280148] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114982.280196] ata1: link online but device misclassified, retrying
[114982.280205] ata1: limiting SATA link speed to 1.5 Gbps
[114982.280255] ata1: hard resetting link
[114987.330035] ata1: SRST failed (errno=-16)
[114987.330145] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[114987.330178] ata1: link online but device misclassified, device 
detection might fail
[114987.330438] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t3
[114987.330441] ata1: hotplug_status 0x80
[114987.330493] ata1: hard resetting link
[114993.280035] ata1: link is slow to respond, please be patient (ready=-19)
[114997.360597] ata1: SRST failed (errno=-16)
[114997.360699] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[114997.360740] ata1: link online but device misclassified, retrying
[114997.360781] ata1: hard resetting link
[115003.330084] ata1: link is slow to respond, please be patient (ready=-19)
[115007.410222] ata1: SRST failed (errno=-16)
[115007.410327] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115007.410363] ata1: link online but device misclassified, retrying
[115007.410399] ata1: hard resetting link
[115013.360038] ata1: link is slow to respond, please be patient (ready=-19)
[115042.460168] ata1: SRST failed (errno=-16)
[115042.460271] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115042.460304] ata1: link online but device misclassified, retrying
[115042.460313] ata1: limiting SATA link speed to 1.5 Gbps
[115042.460346] ata1: hard resetting link
[115047.510048] ata1: SRST failed (errno=-16)
[115047.510143] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[115047.510176] ata1: link online but device misclassified, device 
detection might fail
[115047.510524] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t2
[115047.510527] ata1: hotplug_status 0x80
[115047.510578] ata1: hard resetting link
[115053.460097] ata1: link is slow to respond, please be patient (ready=-19)
[115057.540039] ata1: SRST failed (errno=-16)
[115057.540141] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115057.540175] ata1: link online but device misclassified, retrying
[115057.540222] ata1: hard resetting link
[115063.510044] ata1: link is slow to respond, please be patient (ready=-19)
[115067.590036] ata1: SRST failed (errno=-16)
[115067.590137] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115067.590178] ata1: link online but device misclassified, retrying
[115067.590226] ata1: hard resetting link
[115073.550062] ata1: link is slow to respond, please be patient (ready=-19)
[115102.650031] ata1: SRST failed (errno=-16)
[115102.650130] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115102.650264] ata1: link online but device misclassified, retrying
[115102.650274] ata1: limiting SATA link speed to 1.5 Gbps
[115102.650310] ata1: hard resetting link
[115107.700035] ata1: SRST failed (errno=-16)
[115107.700131] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[115107.700171] ata1: link online but device misclassified, device 
detection might fail
[115107.700500] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t1
[115107.700503] ata1: hotplug_status 0x80
[115107.700556] ata1: hard resetting link
[115113.652245] ata1: link is slow to respond, please be patient (ready=-19)
[115117.740038] ata1: SRST failed (errno=-16)
[115117.740133] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115117.740173] ata1: link online but device misclassified, retrying
[115117.740207] ata1: hard resetting link
[115123.690028] ata1: link is slow to respond, please be patient (ready=-19)
[115127.770479] ata1: SRST failed (errno=-16)
[115127.770587] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115127.770626] ata1: link online but device misclassified, retrying
[115127.770646] ata1: hard resetting link
[115133.720038] ata1: link is slow to respond, please be patient (ready=-19)
[115162.830077] ata1: SRST failed (errno=-16)
[115162.830179] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115162.830212] ata1: link online but device misclassified, retrying
[115162.830220] ata1: limiting SATA link speed to 1.5 Gbps
[115162.830268] ata1: hard resetting link
[115167.880253] ata1: SRST failed (errno=-16)
[115167.880362] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[115167.880404] ata1: link online but device misclassified, device 
detection might fail
[115167.880414] ata1: EH pending after 5 tries, giving up
[115167.880436] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[115167.880440] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[115167.880445] Descriptor sense data with sense descriptors (in hex):
[115167.880447]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[115167.880454]         00 00 00 00
[115167.880457] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[115167.880461] end_request: I/O error, dev sda, sector 31866624
[115167.880465] Buffer I/O error on device sda, logical block 3983328
[115167.880470] Buffer I/O error on device sda, logical block 3983329
[115167.880473] Buffer I/O error on device sda, logical block 3983330
[115167.880476] Buffer I/O error on device sda, logical block 3983331
[115167.880479] Buffer I/O error on device sda, logical block 3983332
[115167.880483] Buffer I/O error on device sda, logical block 3983333
[115167.880486] Buffer I/O error on device sda, logical block 3983334
[115167.880489] Buffer I/O error on device sda, logical block 3983335
[115167.880492] Buffer I/O error on device sda, logical block 3983336
[115167.880496] Buffer I/O error on device sda, logical block 3983337
[115167.880644] ata1: EH complete
[115167.880653] ata1.00: detaching (SCSI 0:0:0:0)
[115167.880945] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[115167.883403] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[115167.883412] sd 0:0:0:0: [sda] Stopping disk
[115167.883895] sd 0:0:0:0: [sda] START_STOP FAILED
[115167.883897] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

modprobe -r sata_promise adds the following to dmesg:

[115788.005895] ata2.00: disabled
[115788.006119] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[115788.006153] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[115788.006157] sd 1:0:0:0: [sdb] Stopping disk
[115788.006165] sd 1:0:0:0: [sdb] START_STOP FAILED
[115788.006167] sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
[115788.006438] ata3.00: disabled
[115788.006588] sd 2:0:0:0: [sdc] Synchronizing SCSI cache
[115788.006610] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[115788.006614] sd 2:0:0:0: [sdc] Stopping disk
[115788.006621] sd 2:0:0:0: [sdc] START_STOP FAILED
[115788.006623] sd 2:0:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
[115788.006743] ata4.00: disabled
[115788.006892] sd 3:0:0:0: [sdd] Synchronizing SCSI cache
[115788.006914] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[115788.006918] sd 3:0:0:0: [sdd] Stopping disk
[115788.006925] sd 3:0:0:0: [sdd] START_STOP FAILED
[115788.006927] sd 3:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[115788.007073] sata_promise 0000:01:08.0: PCI INT A disabled

Then modprobe sata_promise adds to dmesg:

[115974.655463] sata_promise 0000:01:08.0: version 2.12
[115974.655717] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> 
GSI 18 (level, high) -> IRQ 18
[115974.656113] scsi4 : sata_promise
[115974.657795] scsi5 : sata_promise
[115974.657947] scsi6 : sata_promise
[115974.658400] scsi7 : sata_promise
[115974.658466] ata5: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[115974.658473] ata6: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[115974.658477] ata7: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[115974.658482] ata8: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[115980.200009] ata5: link is slow to respond, please be patient (ready=-19)
[115984.700016] ata5: SRST failed (errno=-16)
[115984.700040] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115984.700050] ata5: link online but device misclassified, retrying
[115990.250010] ata5: link is slow to respond, please be patient (ready=-19)
[115994.750011] ata5: SRST failed (errno=-16)
[115994.750035] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[115994.750045] ata5: link online but device misclassified, retrying
[116000.300013] ata5: link is slow to respond, please be patient (ready=-19)
[116029.760011] ata5: SRST failed (errno=-16)
[116029.760034] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116029.760043] ata5: link online but device misclassified, retrying
[116029.760048] ata5: limiting SATA link speed to 1.5 Gbps
[116034.770011] ata5: SRST failed (errno=-16)
[116034.770035] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[116034.770045] ata5: link online but device misclassified, device 
detection might fail
[116035.280132] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116040.280657] ata6.00: qc timeout (cmd 0xec)
[116040.280871] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[116045.830011] ata6: link is slow to respond, please be patient (ready=-19)
[116050.330012] ata6: SRST failed (errno=-16)
[116050.330034] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116050.330043] ata6: link online but device misclassified, retrying
[116055.880744] ata6: link is slow to respond, please be patient (ready=-19)
[116060.380009] ata6: SRST failed (errno=-16)
[116060.380032] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116060.380042] ata6: link online but device misclassified, retrying
[116065.930012] ata6: link is slow to respond, please be patient (ready=-19)
[116095.390009] ata6: SRST failed (errno=-16)
[116095.390032] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116095.390041] ata6: link online but device misclassified, retrying
[116095.390046] ata6: limiting SATA link speed to 1.5 Gbps
[116100.400009] ata6: SRST failed (errno=-16)
[116100.400031] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[116100.400041] ata6: link online but device misclassified, device 
detection might fail
[116100.910044] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116105.910028] ata7.00: qc timeout (cmd 0xec)
[116105.910242] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[116111.460073] ata7: link is slow to respond, please be patient (ready=-19)
[116115.960011] ata7: SRST failed (errno=-16)
[116115.960033] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116115.960043] ata7: link online but device misclassified, retrying
[116121.510016] ata7: link is slow to respond, please be patient (ready=-19)
[116126.010016] ata7: SRST failed (errno=-16)
[116126.010039] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116126.010048] ata7: link online but device misclassified, retrying
[116131.560010] ata7: link is slow to respond, please be patient (ready=-19)
[116161.020012] ata7: SRST failed (errno=-16)
[116161.020035] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116161.020044] ata7: link online but device misclassified, retrying
[116161.020049] ata7: limiting SATA link speed to 1.5 Gbps
[116166.030012] ata7: SRST failed (errno=-16)
[116166.030035] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[116166.030044] ata7: link online but device misclassified, device 
detection might fail
[116166.540047] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116171.540029] ata8.00: qc timeout (cmd 0xec)
[116171.540244] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[116177.090018] ata8: link is slow to respond, please be patient (ready=-19)
[116181.590010] ata8: SRST failed (errno=-16)
[116181.590033] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116181.590042] ata8: link online but device misclassified, retrying
[116187.140011] ata8: link is slow to respond, please be patient (ready=-19)
[116191.640010] ata8: SRST failed (errno=-16)
[116191.640034] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116191.640043] ata8: link online but device misclassified, retrying
[116197.190010] ata8: link is slow to respond, please be patient (ready=-19)
[116226.650011] ata8: SRST failed (errno=-16)
[116226.650034] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[116226.650044] ata8: link online but device misclassified, retrying
[116226.650048] ata8: limiting SATA link speed to 1.5 Gbps
[116231.660075] ata8: SRST failed (errno=-16)
[116231.660098] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[116231.660107] ata8: link online but device misclassified, device 
detection might fail

I tried modprobe -r and modprobing again but with the same result.

Best regards,

Peter

