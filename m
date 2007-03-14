From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Wed, 14 Mar 2007 17:15:06 +0900
Message-ID: <45F7AF0A.1030204@gmail.com>
References: <45F5465F.6050709@gmail.com> <45F55E21.4030208@garzik.org> <45F7AC3E.20700@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:46858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXCNIPN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 04:15:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so506248uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 01:15:11 -0700 (PDT)
In-Reply-To: <45F7AC3E.20700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>

Albert Lee wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>
>>> [libata]
>>> And, as the device requires custom high level driver, libata fails
>>> miserably.  Would it be worth to try support these devices?  Or are
>>> they just too outdated to put the effort in?
>>
>> What SCSI peripheral device type does it report, when booted under libata?
>>
>>     Jeff
>>
>>
>> P.S.  As an aside, this reminds to unpack the SATA tape drive I was
>> handed many moons ago, and test it with libata.
>>
> 
> Libata works well with my zip 100 drive since 2.6.18 or even earlier.
> I just test it again with 2.6.20.3, it looks good on detection (except
> the "abnormal status 0x7F on port 0xE08895DF" warning):
> 
> ata3.00: ATAPI, max UDMA/33
> ata3.01: ATAPI, max UDMA/33
> ata3.00: configured for UDMA/33
> ata3.01: configured for UDMA/33
> scsi3 : pata_pdc2027x
> ATA: abnormal status 0x7F on port 0xE08895DF
> ATA: abnormal status 0x7F on port 0xE08895DF
> ata4.00: ATAPI, max PIO2, CDB intr
> ata4.00: configured for PIO2
> scsi 2:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S07 PQ: 0 ANSI: 5
> scsi 2:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A105 PQ: 0 ANSI: 5
> scsi 3:0:0:0: Direct-Access     IOMEGA   ZIP 100          14.A PQ: 0 ANSI: 5
> 
> Read/write/eject also works without error.
> Full dmesg attached for your reference.

Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
don't think the low level driver is causing the difference.  They both
use the standard libata HSM implementation.  Any ideas?  Stanislav, can
you try to connect that zip drive to another IDE controller?

Thanks.

-- 
tejun
