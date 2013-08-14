From: Bruce Link <Bruce@1045.ca>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Wed, 14 Aug 2013 17:17:12 -0500
Message-ID: <520C01E8.9040302@1045.ca>
References: <520AB4D8.1000208@1045.ca> <520B210B.5040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:1264 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115Ab3HNWRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Aug 2013 18:17:34 -0400
In-Reply-To: <520B210B.5040700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, 1063474@bugs.launchpad.net

On 8/14/2013 1:17 AM, Robert Hancock wrote:
> On 08/13/2013 04:36 PM, Bruce Link wrote:
>> On bootup, when trying to attach to a Lite-on iHOS-104 DVD drive, the
>> kernel attempts to establish a connection to the CD drive at a variety
>> of speeds. Ultimately it fails with a "TEST_UNIT_READY failed
>> (err_mask=0x4)" message
>>
>> ****************************************************************
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1063474
>>
>> ****************************************************************
>> The relevant DMESG output is listed below:
>> watchtv@teevee:~$ dmesg|grep ata5
>> [    1.088342] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400
>> irq 23
>> [    1.556031] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    1.564134] ata5.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
>> [    1.580115] ata5.00: configured for UDMA/100
>> [    6.580029] ata5.00: qc timeout (cmd 0xa0)
>> [    6.580036] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
>> [    7.048044] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    7.072129] ata5.00: configured for UDMA/100
>> [   29.856040] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [   29.856063] ata5.00: cmd a0/01:00:00:60:00/00:00:00:00:00/a0 tag 0
>> dma 96 in
>> [   29.856065] ata5.00: status: { DRDY }
>> [   29.856071] ata5: hard resetting link
>> [   29.856073] ata5: nv: skipping hardreset on occupied port
>> [   30.324070] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   30.348152] ata5.00: configured for UDMA/100
>> [   35.348125] ata5.00: qc timeout (cmd 0xa0)
>> [   35.348132] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
>> [   35.348139] ata5: hard resetting link
>> [   35.348141] ata5: nv: skipping hardreset on occupied port
>> [   35.816115] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   35.840125] ata5.00: configured for UDMA/100
>> [   36.835824] ata5: EH complete
>> [   67.840151] ata5: limiting SATA link speed to 1.5 Gbps
>> [   67.840159] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [   67.840178] ata5.00: cmd a0/01:00:00:80:00/00:00:00:00:00/a0 tag 0
>> dma 16512 in
>> [   67.840181] ata5.00: status: { DRDY }
>> [   67.840187] ata5: hard resetting link
>> [   67.840188] ata5: nv: skipping hardreset on occupied port
>> [   68.308056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   68.332176] ata5.00: configured for UDMA/100
>> [   68.343497] ata5: EH complete
>> [   75.808054] ata5.00: limiting speed to UDMA/66:PIO4
>> [   75.808061] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [   75.808081] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0
>> dma 16416 in
>> [   75.808084] ata5.00: status: { DRDY }
>> [   75.808089] ata5: hard resetting link
>> [   75.808091] ata5: nv: skipping hardreset on occupied port
>> [   76.276050] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   76.300125] ata5.00: configured for UDMA/66
>> [   76.307490] ata5: EH complete
>> [  136.868049] ata5.00: limiting speed to UDMA/33:PIO4
>> [  136.868058] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [  136.868078] ata5.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0
>> dma 16416 in
>> [  136.868081] ata5.00: status: { DRDY }
>> [  136.868087] ata5: hard resetting link
>> [  136.868089] ata5: nv: skipping hardreset on occupied port
>> [  137.332073] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  137.356170] ata5.00: configured for UDMA/33
>> [  137.866272] ata5: EH complete
>
> These NVIDIA SATA controllers are a pain as they all seem to have a 
> different set of bugs related to hardreset, etc. What happens if you 
> boot up without the drive connected and then plug in the cable after 
> the system boots up?
Roughly the same error is returned. See below for the dmesg output.

root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0# 
echo "- - -" > /sys/class/scsi_host/host4/scan
root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0# 
dmesg|grep ata5
[    1.030224] ata5: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400 
irq 20
[    1.354216] ata5: SATA link down (SStatus 0 SControl 300)
[  944.773288] ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
[  944.773304] ata5: SError: { PHYRdyChg CommWake }
[  944.773322] ata5: hard resetting link
[  945.652070] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  945.660176] ata5.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
[  945.676165] ata5.00: configured for UDMA/100
[  950.676049] ata5.00: qc timeout (cmd 0xa0)
[  950.676056] ata5.00: TEST_UNIT_READY failed (err_mask=0x5)
[  950.676064] ata5: hard resetting link
[  950.676066] ata5: nv: skipping hardreset on occupied port
[  951.144073] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  951.168168] ata5.00: configured for UDMA/100
[  956.168049] ata5.00: qc timeout (cmd 0xa0)
[  956.168057] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
[  956.168061] ata5: limiting SATA link speed to 1.5 Gbps
[  956.168064] ata5.00: limiting speed to UDMA/100:PIO3
[  956.168070] ata5: hard resetting link
[  956.168072] ata5: nv: skipping hardreset on occupied port
[  956.636056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  956.660169] ata5.00: configured for UDMA/100
[  961.660036] ata5.00: qc timeout (cmd 0xa0)
[  961.660044] ata5.00: TEST_UNIT_READY failed (err_mask=0x4)
[  961.660046] ata5.00: disabled
[  961.660061] ata5: hard resetting link
[  962.544045] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  962.544061] ata5: EH complete
root@teevee:/sys/devices/pci0000:00/0000:00:06.0/ata1/host0/scsi_host/host0#

