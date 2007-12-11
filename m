From: trash can <thetrashcan@earthlink.net>
Subject: Re: Iomega ZIP-100 drive unsupported with jmicron JMB361 chip?
Date: Tue, 11 Dec 2007 14:05:26 -0500
Message-ID: <475EDF76.4000703@earthlink.net>
References: <fa.yONLBG7CMuz80f4dUP5r/5k7emw@ifi.uio.no> <475DD7FF.4030906@shaw.ca> <475EAEDD.9090905@earthlink.net> <475EC0D1.8010200@rtr.ca> <475EC163.8070305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:42683 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751705AbXLKTHV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 14:07:21 -0500
In-Reply-To: <475EC163.8070305@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the note. Zip drive as only device on the bus did not work
for me. kernel is correctly identifying the Jmicron chip.

Removed the DVD drive and jumpered the Zip drive to Master. BIOS
set to IDE. Fedora 8 with nash on boot:
Buffer I/O error on dev/sdc locaical block 0

dmesg:
Buffer I/O error on device sdc, logical block 0
sd 4:0:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 4:0:0:0: [sdc] Sense Key : Hardware Error [current]
sd 4:0:0:0: [sdc] Add. Sense: Scsi parity error
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
sd 4:0:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 4:0:0:0: [sdc] Sense Key : Hardware Error [current]
sd 4:0:0:0: [sdc] Add. Sense: Scsi parity error
end_request: I/O error, dev sdc, sector 0
Buffer I/O error on device sdc, logical block 0
Dev sdc: unable to read RDB block 0

udev creates a /dev/sdc only.

With DVD removed and BIOS set to AHCI device changes to sda
Fedora 8: nash:
Buffer I/O error on device sda, logical block 0

dmesg:
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Hardware Error [current]
sd 0:0:0:0: [sda] Add. Sense: Scsi parity error
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
Dev sda: unable to read RDB block 0


Mark Lord wrote:
> Mark Lord wrote:
>>
>> I missed the early part of this thread,
>> but here is a data point that may or may not be useful.
>>
>> I have an ASUS mobo here with an onboard JM363 SATA/PATA controller
>> (verified by looking at the actual chip).
>>
>> It works fine when in AHCI mode with a PATA ATAPI ZIP100 drive
>> all by itself.  No other configurations tested.
>> This is with kernel 2.6.24-rc4-git?.
> ..
> 
> Oh yeah.. that's with libata controlling all drives in the system.
> 
> This exact same mobo was used for a while with a PATA DVD-RW (no ZIP drive)
> under older kernels using drivers/IDE, but was unreliable in that
> configuration
> (Ubuntu Edgy).   Ditto when the PATA DVD-RW was replaced with a SATA
> DVD-RW.
> 
> -ml
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHXt92z1/aqdDsM3URAvoNAKD4jBHDbhppOx6Fa8URPjbgN+jc9gCdEc6s
HomNnFPdQEDa6m8aJKB+vLM=
=PkYa
-----END PGP SIGNATURE-----
