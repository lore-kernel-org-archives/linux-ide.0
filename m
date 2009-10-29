From: Peter Klotz <peter.klotz@aon.at>
Subject: Errors when powering on eSATA box
Date: Thu, 29 Oct 2009 21:41:10 +0100
Message-ID: <4AE9FDE6.5040203@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from warsl404pip5.highway.telekom.at ([195.3.96.77]:21582 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756662AbZJ2UlJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Oct 2009 16:41:09 -0400
Received: from 188-23-170-36.adsl.highway.telekom.at (HELO [192.168.0.102]) ([188.23.170.36])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 29 Oct 2009 20:41:11 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have an eSATA box (2 HDDs) that when operated in BIG mode shows lots 
of errors during startup.

Both HDDs are started then stopped and started again.

When first starting up the system reports a size of 7.99 GiB, finally 
the correct value of 2.72 TiB is displayed.

Can I trust a system showing the errors below?

Regards, Peter.


[ 8893.208921] ata6: hard resetting link
[ 8898.990123] ata6: link is slow to respond, please be patient (ready=0)
[ 8901.332637] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 8901.333317] ACPI Error: Attempt to CreateField of length zero 
20090521 dsopcode-529
[ 8901.333334] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
[ 8901.333458] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
[ 8901.333586] ata6.00: _GTF evaluation failed (AE 0x3004)
[ 8901.333596] ata6.00: ATA-7: Config   Disk 0, 1.1589, max MWDMA2
[ 8901.333603] ata6.00: 16777215 sectors, multi 1: LBA
[ 8901.334284] ACPI Error: Attempt to CreateField of length zero 
20090521 dsopcode-529
[ 8901.334299] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
[ 8901.334420] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
[ 8901.334547] ata6.00: _GTF evaluation failed (AE 0x3004)
[ 8901.334584] ata6.00: configured for PIO4
[ 8901.334599] ata6: EH complete
[ 8901.334770] scsi 5:0:0:0: Direct-Access     ATA      Config   Disk 0 
  1.15 PQ: 0 ANSI: 5
[ 8901.337074] sd 5:0:0:0: Attached scsi generic sg3 type 0
[ 8901.337089] sd 5:0:0:0: [sdc] 16777215 512-byte logical blocks: (8.58 
GB/7.99 GiB)
[ 8901.337205] sd 5:0:0:0: [sdc] Write Protect is off
[ 8901.337273] sd 5:0:0:0: [sdc] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[ 8901.337603]  sdc:
[ 8901.339604] sd 5:0:0:0: [sdc] Attached SCSI disk
[ 8906.325426] ata6: hard resetting link
[ 8907.070160] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 8907.070315] ata6.00: model number mismatch 'Config   Disk 0' != 
'External Disk 0'
[ 8907.070333] ata6: limiting SATA link speed to 1.5 Gbps
[ 8912.072673] ata6: hard resetting link
[ 8912.420149] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 8912.420301] ata6.00: model number mismatch 'Config   Disk 0' != 
'External Disk 0'
[ 8912.420316] ata6.00: disabled
[ 8917.420107] ata6: hard resetting link
[ 8917.780127] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 8917.780857] ACPI Error: Attempt to CreateField of length zero 
20090521 dsopcode-529
[ 8917.780873] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
[ 8917.780996] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
[ 8917.781124] ata6.00: _GTF evaluation failed (AE 0x3004)
[ 8917.781136] ata6.00: ATA-7: External Disk 0, 1.1589, max UDMA/133
[ 8917.781143] ata6.00: 5860554336 sectors, multi 1: LBA48 NCQ (depth 31/32)
[ 8917.781869] ACPI Error: Attempt to CreateField of length zero 
20090521 dsopcode-529
[ 8917.781883] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.RATA] (Node ffff88013ba324c0), AE_AML_OPERAND_VALUE
[ 8917.782004] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.IDE0.PRT5._GTF] (Node ffff88013ba326a0), AE_AML_OPERAND_VALUE
[ 8917.782130] ata6.00: _GTF evaluation failed (AE 0x3004)
[ 8917.782168] ata6.00: configured for UDMA/133
[ 8917.782182] ata6: EH complete
[ 8917.782206] ata6.00: detaching (SCSI 5:0:0:0)
[ 8917.782811] sd 5:0:0:0: [sdc] Stopping disk
[ 8920.518523] scsi 5:0:0:0: Direct-Access     ATA      External Disk 0 
  1.15 PQ: 0 ANSI: 5
[ 8920.520478] sd 5:0:0:0: [sdc] 5860554336 512-byte logical blocks: 
(3.00 TB/2.72 TiB)
[ 8920.520593] sd 5:0:0:0: [sdc] Write Protect is off
[ 8920.520660] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 8920.520986]  sdc:
[ 8920.524398] sd 5:0:0:0: Attached scsi generic sg3 type 0
[ 8924.295185]  unknown partition table
[ 8924.295659] sd 5:0:0:0: [sdc] Attached SCSI disk
