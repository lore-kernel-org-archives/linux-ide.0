From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata and md issues with 2.9.1-rc1 - id10t error
Date: Thu, 26 Aug 2004 16:21:35 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412DD5CF.7040409@wasp.net.au>
References: <412B79DF.2000705@wasp.net.au> <412BC1C4.2060506@clanhk.org> <412C1B38.7090401@wasp.net.au> <412DBBCE.2000403@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:13445 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268798AbUHZMVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Aug 2004 08:21:00 -0400
In-Reply-To: <412DBBCE.2000403@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "J. Ryan Earl" <heretic@clanhk.org>, Jeff Garzik <jgarzik@pobox.com>

Brad Campbell wrote:
> Brad Campbell wrote:
> 
>> J. Ryan Earl wrote:
>>
>>> Brad Campbell wrote:
>>>
>>>> Just a heads up. I'm experiencing "issues" with 2.6.9-rc1 that don't 
>>>> occur with 2.6.5.
>>>>
>>>> I run a 10 disk raid-5 on 3xPromise SATA150 cards and a 2 disk 
>>>> raid-0 on the on-board VIA chipset.
>>>> The 10 disks are Maxtor Maxline-II SATA drives and the raid-0 is a 
>>>> pair of WD2000JB drives with
>>>> Addonics SATA->PATA converters. 
>>>
>>>
>>>
>>>
>>> Did you try RAID-0 with the pair of Western Digital drives on the two 
>>> free Promise slots?  If that fails similarly, it might not be a 
>>> libata issue.
>>
>>
> 
> Worse. It won't even boot!
> 

> Of course, on anything earlier than 2.6.7-rc1 none of this happens and 
> it all works swimmingly!

Ignore the retard people.. move along.. nothing to see here..

I was tesing with 2.6.7-rc1 <ack>

Now repeat after me, I will check my uname -a before I e-mail, I will check my uname -a before I email!

With 2.6.9-rc1 there are no issues with the promise driver, there are issues still with the sata_via 
driver.

I'll keep poking at the via driver.
Here is a full debug log of the error occuring (on the via interface, on a 2.6.9-rc1 kernel with a 
WD ATA drive via the PATA->SATA bridge)
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
ata_scsi_dump_cdb: CDB (13:0,0,0) 2a 00 00 00 05 40 00 04 00
ata_scsi_translate: ENTER
ata_scsi_rw_xlat: ten-byte command
ata_sg_setup: ENTER, ata13
ata_sg_setup: 128 sg elements mapped
ata_fill_sg: PRD[0] = (0x1CA09000, 0x1000)
ata_fill_sg: PRD[1] = (0x1CA0C000, 0x1000)
ata_fill_sg: PRD[2] = (0x1CA0B000, 0x1000)
ata_fill_sg: PRD[3] = (0x1CA0D000, 0x1000)
ata_fill_sg: PRD[4] = (0x1C9E6000, 0x1000)
ata_fill_sg: PRD[5] = (0x1CA13000, 0x1000)
ata_fill_sg: PRD[6] = (0x1CA14000, 0x1000)
ata_fill_sg: PRD[7] = (0x1CA15000, 0x1000)
ata_fill_sg: PRD[8] = (0x1CA19000, 0x1000)
ata_fill_sg: PRD[9] = (0x1CA1A000, 0x1000)
ata_fill_sg: PRD[10] = (0x1CA27000, 0x1000)
ata_fill_sg: PRD[11] = (0x1CA28000, 0x1000)
ata_fill_sg: PRD[12] = (0x1CA29000, 0x1000)
ata_fill_sg: PRD[13] = (0x1CA2A000, 0x1000)
ata_fill_sg: PRD[14] = (0x1CA2B000, 0x1000)
ata_fill_sg: PRD[15] = (0x1CA2E000, 0x1000)
ata_fill_sg: PRD[16] = (0x1CA2F000, 0x1000)
ata_fill_sg: PRD[17] = (0x1CA30000, 0x1000)
ata_fill_sg: PRD[18] = (0x1CA33000, 0x1000)
ata_fill_sg: PRD[19] = (0x1CA34000, 0x1000)
ata_fill_sg: PRD[20] = (0x1CA38000, 0x1000)
ata_fill_sg: PRD[21] = (0x1CA39000, 0x1000)
ata_fill_sg: PRD[22] = (0x1CA3B000, 0x1000)
ata_fill_sg: PRD[23] = (0x1CA3D000, 0x1000)
ata_fill_sg: PRD[24] = (0x1CA3E000, 0x1000)
ata_fill_sg: PRD[25] = (0x1CA3F000, 0x1000)
ata_fill_sg: PRD[26] = (0x1CA42000, 0x1000)
ata_fill_sg: PRD[27] = (0x1CA43000, 0x1000)
ata_fill_sg: PRD[28] = (0x1CA44000, 0x1000)
ata_fill_sg: PRD[29] = (0x1CA45000, 0x1000)
ata_fill_sg: PRD[30] = (0x1CA48000, 0x1000)
ata_fill_sg: PRD[31] = (0x1CA4F000, 0x1000)
ata_fill_sg: PRD[32] = (0x1CA50000, 0x1000)
ata_fill_sg: PRD[33] = (0x1C9D9000, 0x1000)
ata_fill_sg: PRD[34] = (0x1C9DD000, 0x1000)
ata_fill_sg: PRD[35] = (0x1C952000, 0x1000)
ata_fill_sg: PRD[36] = (0x1CA12000, 0x1000)
ata_fill_sg: PRD[37] = (0x1CA11000, 0x1000)
ata_fill_sg: PRD[38] = (0x1CA0E000, 0x1000)
ata_fill_sg: PRD[39] = (0x1CA0F000, 0x1000)
ata_fill_sg: PRD[40] = (0x1CA52000, 0x1000)
ata_fill_sg: PRD[41] = (0x1CA55000, 0x1000)
ata_fill_sg: PRD[42] = (0x1CA56000, 0x1000)
ata_fill_sg: PRD[43] = (0x1CA58000, 0x1000)
ata_fill_sg: PRD[44] = (0x1CA5A000, 0x1000)
ata_fill_sg: PRD[45] = (0x1CA5F000, 0x1000)
ata_fill_sg: PRD[46] = (0x1CA60000, 0x1000)
ata_fill_sg: PRD[47] = (0x1CA61000, 0x1000)
ata_fill_sg: PRD[48] = (0x1CA63000, 0x1000)
ata_fill_sg: PRD[49] = (0x1CA65000, 0x1000)
ata_fill_sg: PRD[50] = (0x1CA66000, 0x1000)
ata_fill_sg: PRD[51] = (0x1CA67000, 0x1000)
ata_fill_sg: PRD[52] = (0x1CA6A000, 0x1000)
ata_fill_sg: PRD[53] = (0x1CA6B000, 0x1000)
ata_fill_sg: PRD[54] = (0x1CA6C000, 0x1000)
ata_fill_sg: PRD[55] = (0x1E881000, 0x1000)
ata_fill_sg: PRD[56] = (0x1CA6E000, 0x1000)
ata_fill_sg: PRD[57] = (0x1CA6F000, 0x1000)
ata_fill_sg: PRD[58] = (0x1CA70000, 0x1000)
ata_fill_sg: PRD[59] = (0x1CA72000, 0x1000)
ata_fill_sg: PRD[60] = (0x1CA74000, 0x1000)
ata_fill_sg: PRD[61] = (0x1CA75000, 0x1000)
ata_fill_sg: PRD[62] = (0x1CA77000, 0x1000)
ata_fill_sg: PRD[63] = (0x1CA79000, 0x1000)
ata_fill_sg: PRD[64] = (0x1CACA000, 0x1000)
ata_fill_sg: PRD[65] = (0x1CAE6000, 0x1000)
ata_fill_sg: PRD[66] = (0x1CAA9000, 0x1000)
ata_fill_sg: PRD[67] = (0x1CAA8000, 0x1000)
ata_fill_sg: PRD[68] = (0x1CAF7000, 0x1000)
ata_fill_sg: PRD[69] = (0x1CAF8000, 0x1000)
ata_fill_sg: PRD[70] = (0x1CAF9000, 0x1000)
ata_fill_sg: PRD[71] = (0x1CB68000, 0x1000)
ata_fill_sg: PRD[72] = (0x1CB6B000, 0x1000)
ata_fill_sg: PRD[73] = (0x1CB6C000, 0x1000)
ata_fill_sg: PRD[74] = (0x1CB6D000, 0x1000)
ata_fill_sg: PRD[75] = (0x1FB1B000, 0x1000)
ata_fill_sg: PRD[76] = (0x1CB6E000, 0x1000)
ata_fill_sg: PRD[77] = (0x1CB79000, 0x1000)
ata_fill_sg: PRD[78] = (0x1CB7A000, 0x1000)
ata_fill_sg: PRD[79] = (0x1CB7B000, 0x1000)
ata_fill_sg: PRD[80] = (0x1CB7D000, 0x1000)
ata_fill_sg: PRD[81] = (0x1CB7F000, 0x1000)
ata_fill_sg: PRD[82] = (0x1CB80000, 0x1000)
ata_fill_sg: PRD[83] = (0x1CB81000, 0x1000)
ata_fill_sg: PRD[84] = (0x1CB84000, 0x1000)
ata_fill_sg: PRD[85] = (0x1CB85000, 0x1000)
ata_fill_sg: PRD[86] = (0x1F91F000, 0x1000)
ata_fill_sg: PRD[87] = (0x1CB86000, 0x1000)
ata_fill_sg: PRD[88] = (0x1CB89000, 0x1000)
ata_fill_sg: PRD[89] = (0x1CB8A000, 0x1000)
ata_fill_sg: PRD[90] = (0x1CB8B000, 0x1000)
ata_fill_sg: PRD[91] = (0x1CB8D000, 0x1000)
ata_fill_sg: PRD[92] = (0x1CB8F000, 0x1000)
ata_fill_sg: PRD[93] = (0x1CB90000, 0x1000)
ata_fill_sg: PRD[94] = (0x1CB91000, 0x1000)
ata_fill_sg: PRD[95] = (0x1CB93000, 0x1000)
ata_fill_sg: PRD[96] = (0x1CB95000, 0x1000)
ata_fill_sg: PRD[97] = (0x1CB51000, 0x1000)
ata_fill_sg: PRD[98] = (0x1CB96000, 0x1000)
ata_fill_sg: PRD[99] = (0x1CB99000, 0x1000)
ata_fill_sg: PRD[100] = (0x1CB9A000, 0x1000)
ata_fill_sg: PRD[101] = (0x1CB9B000, 0x1000)
ata_fill_sg: PRD[102] = (0x1CB9C000, 0x1000)
ata_fill_sg: PRD[103] = (0x1CB9F000, 0x1000)
ata_fill_sg: PRD[104] = (0x1CBA2000, 0x1000)
ata_fill_sg: PRD[105] = (0x1CBA5000, 0x1000)
ata_fill_sg: PRD[106] = (0x1CBA7000, 0x1000)
ata_fill_sg: PRD[107] = (0x1CBA9000, 0x1000)
ata_fill_sg: PRD[108] = (0x1CBAA000, 0x1000)
ata_fill_sg: PRD[109] = (0x1CBAB000, 0x1000)
ata_fill_sg: PRD[110] = (0x1CBAD000, 0x1000)
ata_fill_sg: PRD[111] = (0x1CBAF000, 0x1000)
ata_fill_sg: PRD[112] = (0x1CBB0000, 0x1000)
ata_fill_sg: PRD[113] = (0x1CBB1000, 0x1000)
ata_fill_sg: PRD[114] = (0x1CBB5000, 0x1000)
ata_fill_sg: PRD[115] = (0x1CBB6000, 0x1000)
ata_fill_sg: PRD[116] = (0x1CBB7000, 0x1000)
ata_fill_sg: PRD[117] = (0x1CBB8000, 0x1000)
ata_fill_sg: PRD[118] = (0x1CBBB000, 0x1000)
ata_fill_sg: PRD[119] = (0x1CBBC000, 0x1000)
ata_fill_sg: PRD[120] = (0x1CBBD000, 0x1000)
ata_fill_sg: PRD[121] = (0x1CBBF000, 0x1000)
ata_fill_sg: PRD[122] = (0x1CBC1000, 0x1000)
ata_fill_sg: PRD[123] = (0x1CB41000, 0x1000)
ata_fill_sg: PRD[124] = (0x1CB43000, 0x1000)
ata_fill_sg: PRD[125] = (0x1CB42000, 0x1000)
ata_fill_sg: PRD[126] = (0x1CB4E000, 0x1000)
ata_fill_sg: PRD[127] = (0x1CB46000, 0x1000)
ata_dev_select: ENTER, ata13: device 0, wait 1
ata_tf_load_pio: hob: feat 0x0 nsect 0x4, lba 0x0 0x0 0x0
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x40 0x5 0x0
ata_tf_load_pio: device 0xE0
ata_exec_command_pio: ata13: cmd 0x35
ata_scsi_translate: EXIT
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3

<30 seconds of these snipped>

pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata13: command 0x35 timeout, stat 0xd0 host_stat 0x0
ata_sg_clean: unmapping 128 sg elements
ata13: status=0xd0 { Busy }
SCSI error : <12 0 0 0> return code = 0x8000002
FMK EOM ILI Current sda: sense = 70 f7
ASC=28 ASCQ=c0
end_request: I/O error, dev sda, sector 1344
Buffer I/O error on device md1, logical block 168
lost page write due to I/O error on md1
ata_qc_complete: EXIT
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (13:0,0,0) 2a 00 00 00 05 48 00 03 f8
ata_scsi_translate: ENTER
ata_scsi_rw_xlat: ten-byte command
ata_sg_setup: ENTER, ata13
ata_sg_setup: 127 sg elements mapped


So, in summary. There is an issue with these WD drives using PATA->SATA bridges on the on-board VIA 
controller. It does not exhibit this behaviour with Genuine Maxtor SATA drives and it does not 
exhibit this behaviour on 2.6.5. It also makes no difference as to debugging being turned on or off 
(console messages slowing things down a lot)

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)

Off to do some more poking.

Regards,
Brad
