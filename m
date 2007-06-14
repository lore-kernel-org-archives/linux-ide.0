From: "Miguel Medalha" <miguelmedalha@sapo.pt>
Subject: Disk errors reported on boot - kernel 2.6.18
Date: Thu, 14 Jun 2007 07:44:42 +0100
Message-ID: <001201c7ae4f$7d829df0$0901a8c0@medalha>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:48971 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752066AbXFNGve (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jun 2007 02:51:34 -0400
Received: from unknown (HELO medalha) (miguelmedalha@sapo.pt@[82.155.56.159])
          (envelope-sender <miguelmedalha@sapo.pt>)
          by mta14 (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 14 Jun 2007 06:44:53 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Gentlemen

I thought you might be interested in the following:

I just installed CentOS 5 on a computer (kernel-2.6.18-8.1.4.el5.i686) . On 
boot, I get an error message,
related to 2 SATA disks. These errors did NOT appear on version 4.4 
(kernel-smp-2.6.9-42.EL.i586) with the
EXACT same hardware.

Despite the error messages, the disks seem to be working with no problems.

I searched the Net for these errors and they seem to appear with a wide
range of disks, controlers and chip set brands, even with different Linux 
distributions.
The issue seems to be related to the last few kernel versions and is perhaps 
a bug or ill
implemented "feature" of libata or ata_piix.

My configuration:

- 2 Hitachi HDS722512VLSA80 SATA 120 GB Harddisks (first generation, no NCQ)
- Intel P4 3GHz
- Tyan Tomcat i875p (S5102) motherboard, Intel ICH5 disk controler
- 1 GB ECC RAM
- 2 Intel Gb NICs
- 1 Intel 10/100 NIC

Error message follows:

---------------------------------------------------------------------
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
---------------------------------------------------------------------

This repeats another 5 times, after which come the statements:

---------------------------------------------------------------------
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

(Is this duplication normal?)
---------------------------------------------------------------------

The whole thing is repeated for "ata2.00" and "SCSI device sdb"

I connected both disks to a Promise PDC20378 Sata Controler available on the
same board and the error disappears. The configuration stays EXACTLY the 
same,
I only switch both disks' SATA cables to the other 2 connectors.

So, it is related to the use of the Intel 82801EB ICH5 controler that makes
the Southbridge.

Thank you
Miguel Medalha 

