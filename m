From: Torsten Kaiser <just.for.lkml@googlemail.com>
Subject: Re: MSI broken in libata?
Date: Mon, 11 Jan 2010 07:44:51 +0100
Message-ID: <64bb37e1001102244mbb77e9bg2257aec34d653dc3@mail.gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
	 <4B484829.6060405@kernel.org>
	 <64bb37e1001092033r1f0b4defw46c1a07101bb2d1b@mail.gmail.com>
	 <4B4A7BC7.6060106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:47792 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0AKGox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2010 01:44:53 -0500
In-Reply-To: <4B4A7BC7.6060106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

On Mon, Jan 11, 2010 at 2:15 AM, Tejun Heo <tj@kernel.org> wrote:
> On 01/10/2010 01:33 PM, Torsten Kaiser wrote:
>> I did try the patch from Robert Hancock in
>> http://lkml.org/lkml/2010/1/6/417 ,but without success.
>>
>> if you need any more information, or have something for me to try,
>> please just ask. I did look at the code and the documentation about
>> enabling MSI, but did not see anything (obvious) wrong, so I don't
>> know what to try next.
>
> Can you please try the attached patch?

Yes, but as expected it does not change the result.

After applying the patch and doing a test write, I got the following
error messages:
[   89.950055] ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
[   89.960910] ata2.00: failed command: WRITE FPDMA QUEUED
[   89.969853] ata2.00: cmd 61/00:00:fd:27:3e/04:00:01:00:00/40 tag 0
ncq 524288 out
[   89.969855]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   89.992210] ata2.00: status: { DRDY }
[   89.999569] ata2: hard resetting link
[   92.190069] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   97.190041] ata2.00: qc timeout (cmd 0xec)
[   97.197898] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[   97.207622] ata2.00: revalidation failed (errno=-5)
[   97.216094] ata2: hard resetting link
[   99.410049] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  109.410027] ata2.00: qc timeout (cmd 0xec)
[  109.417694] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[  109.427351] ata2.00: revalidation failed (errno=-5)
[  109.435733] ata2: limiting SATA link speed to 1.5 Gbps
[  109.444384] ata2: hard resetting link
[  111.640049] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  141.640029] ata2.00: qc timeout (cmd 0xec)
[  141.647650] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[  141.657255] ata2.00: revalidation failed (errno=-5)
[  141.665577] ata2.00: disabled
[  141.671956] ata2.00: device reported invalid CHS sector 0
[  141.680792] ata2: hard resetting link
[  143.880049] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  143.880065] ata2: EH complete
[  143.880096] sd 1:0:0:0: [sdb] Unhandled error code
[  143.880099] sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
[  143.880106] sd 1:0:0:0: [sdb] CDB: Write(10): 2a 00 01 3e 27 fd 00 04 00 00
[  143.880121] end_request: I/O error, dev sdb, sector 20850685

The last error gets repeated for different sectors, then the xfs
filesystem shuts itself down.

Torsten
