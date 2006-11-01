From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA HSM error
Date: Wed, 01 Nov 2006 11:56:27 +0900
Message-ID: <45480CDB.3050407@gmail.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DFF9@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:581 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423928AbWKAC4g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 21:56:36 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1628785ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 18:56:35 -0800 (PST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DFF9@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linux-ide@vger.kernel.org

Hello,

Rune Torgersen wrote:
> I get the followin gerros once in a while on 2.6.18, running on a
> Freescale 8260 PPC.
> The controller is  Silicon Image SiI3124 , and the drive a seagate
> NL35.2 drive
> 
> Any idea if this is hardware or software?
> 
> ata2: illegal qc_active transition (00000002->000001f8)

The driver says that the attached device is setting spurious command 
active bits.  I have never seen this before.

> ata2.00: exception Emask 0x2 SAct 0x2 SErr 0x0 action 0x2 frozen
> ata2.00: tag 1 cmd 0x61 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
> ata2: soft resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: hard resetting port
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/100
> ata2: EH complete
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back

SRST doesn't really recover the device but hardreset does.

As it's the first report of this kind, I'm more inclined to hw problem. 
  Can you test with different drive?

Thanks.

-- 
tejun
