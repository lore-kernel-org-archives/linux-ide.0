From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Errors when powering on eSATA box
Date: Thu, 29 Oct 2009 17:59:16 -0600
Message-ID: <4AEA2C54.9040502@gmail.com>
References: <4AE9FDE6.5040203@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47976 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbZJ2X7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 19:59:14 -0400
Received: by yxe17 with SMTP id 17so2221491yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2009 16:59:19 -0700 (PDT)
In-Reply-To: <4AE9FDE6.5040203@aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

On 10/29/2009 02:41 PM, Peter Klotz wrote:
> I have an eSATA box (2 HDDs) that when operated in BIG mode shows lots
> of errors during startup.
>
> Both HDDs are started then stopped and started again.
>
> When first starting up the system reports a size of 7.99 GiB, finally
> the correct value of 2.72 TiB is displayed.
>
> Can I trust a system showing the errors below?

I suspect this is one of those funky Silicon Image RAID PMP things that 
has the fake "Config Disk" that shows up to allow configuring the RAID 
array, and then presumably it then goes offline and then the actual RAID 
array device shows up..

>
> Regards, Peter.
>
>
> [ 8893.208921] ata6: hard resetting link
> [ 8898.990123] ata6: link is slow to respond, please be patient (ready=0)
> [ 8901.332637] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 8901.333317] ACPI Error: Attempt to CreateField of length zero
> 20090521 dsopcode-529
> [ 8901.333334] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
> [ 8901.333458] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
> [ 8901.333586] ata6.00: _GTF evaluation failed (AE 0x3004)
> [ 8901.333596] ata6.00: ATA-7: Config Disk 0, 1.1589, max MWDMA2
> [ 8901.333603] ata6.00: 16777215 sectors, multi 1: LBA
> [ 8901.334284] ACPI Error: Attempt to CreateField of length zero
> 20090521 dsopcode-529
> [ 8901.334299] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
> [ 8901.334420] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
> [ 8901.334547] ata6.00: _GTF evaluation failed (AE 0x3004)
> [ 8901.334584] ata6.00: configured for PIO4
> [ 8901.334599] ata6: EH complete
> [ 8901.334770] scsi 5:0:0:0: Direct-Access ATA Config Disk 0 1.15 PQ: 0
> ANSI: 5
> [ 8901.337074] sd 5:0:0:0: Attached scsi generic sg3 type 0
> [ 8901.337089] sd 5:0:0:0: [sdc] 16777215 512-byte logical blocks: (8.58
> GB/7.99 GiB)
> [ 8901.337205] sd 5:0:0:0: [sdc] Write Protect is off
> [ 8901.337273] sd 5:0:0:0: [sdc] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 8901.337603] sdc:
> [ 8901.339604] sd 5:0:0:0: [sdc] Attached SCSI disk
> [ 8906.325426] ata6: hard resetting link
> [ 8907.070160] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 8907.070315] ata6.00: model number mismatch 'Config Disk 0' !=
> 'External Disk 0'
> [ 8907.070333] ata6: limiting SATA link speed to 1.5 Gbps
> [ 8912.072673] ata6: hard resetting link
> [ 8912.420149] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [ 8912.420301] ata6.00: model number mismatch 'Config Disk 0' !=
> 'External Disk 0'
> [ 8912.420316] ata6.00: disabled
> [ 8917.420107] ata6: hard resetting link
> [ 8917.780127] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 8917.780857] ACPI Error: Attempt to CreateField of length zero
> 20090521 dsopcode-529
> [ 8917.780873] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
> [ 8917.780996] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
> [ 8917.781124] ata6.00: _GTF evaluation failed (AE 0x3004)
> [ 8917.781136] ata6.00: ATA-7: External Disk 0, 1.1589, max UDMA/133
> [ 8917.781143] ata6.00: 5860554336 sectors, multi 1: LBA48 NCQ (depth
> 31/32)
> [ 8917.781869] ACPI Error: Attempt to CreateField of length zero
> 20090521 dsopcode-529
> [ 8917.781883] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
> [ 8917.782004] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
> [ 8917.782130] ata6.00: _GTF evaluation failed (AE 0x3004)
> [ 8917.782168] ata6.00: configured for UDMA/133
> [ 8917.782182] ata6: EH complete
> [ 8917.782206] ata6.00: detaching (SCSI 5:0:0:0)
> [ 8917.782811] sd 5:0:0:0: [sdc] Stopping disk
> [ 8920.518523] scsi 5:0:0:0: Direct-Access ATA External Disk 0 1.15 PQ:
> 0 ANSI: 5
> [ 8920.520478] sd 5:0:0:0: [sdc] 5860554336 512-byte logical blocks:
> (3.00 TB/2.72 TiB)
> [ 8920.520593] sd 5:0:0:0: [sdc] Write Protect is off
> [ 8920.520660] sd 5:0:0:0: [sdc] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 8920.520986] sdc:
> [ 8920.524398] sd 5:0:0:0: Attached scsi generic sg3 type 0
> [ 8924.295185] unknown partition table
> [ 8924.295659] sd 5:0:0:0: [sdc] Attached SCSI disk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

