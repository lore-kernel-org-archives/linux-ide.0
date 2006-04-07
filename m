From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Fri, 07 Apr 2006 14:18:13 +0800
Message-ID: <44360425.3080402@tw.ibm.com>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:41605 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932307AbWDGGSg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Apr 2006 02:18:36 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k376IV0M010761
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 02:18:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k376F8TA236820
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 00:15:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k376IUYb013732
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 00:18:31 -0600
In-Reply-To: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Benson <airbatica@verizon.net>
Cc: linux-ide@vger.kernel.org

Jonathan Benson wrote:
> 
>>Could you please give a try to the attached patch and post the  content
> of word 62?
>>If word 62 + SiI 3611 looks good, we can turn on the DMADIR 
> automatically. Thanks!
> 
> Per Albert's request, I've tested his patch to check the status of  word
> 62 with the SiI 3611 bridge chip.  I used kernel version 2.6.17- rc1, as
> 2.6.16 reported fuzz when I applied the patch.  2.6.17-rc1  reported an
> offset, but applied without any errors.  I've tested with  the
> ATAPI_ENABLE_DMADIR workaround enabled, and disabled.  Debugging  is
> disabled.  Looks like word 62 returns 0 as its value, dmesg with  the
> relevant parts attached below.
> 
> If you need any more information, let me know and I'll be happy to 
> provide it.
> 
> Jonathan Benson
> 
> (snip)
> 
> ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
> ata2(0): applying bridge limits
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_sil
> ata3: SATA link up 1.5 Gbps (SStatus 113)
> ata3: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  87:4003
> 88:007f
> ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
> ata3(0): applying bridge limits
> ata3: dev 0 configured for UDMA/100
> scsi2 : sata_sil
> ata4: SATA link up 1.5 Gbps (SStatus 113)
> ata4: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000  87:0000
> 88:0007
> ata4: dev 0 word 62 [0]
> ata4: dev 0 ATAPI, max UDMA/33
> ata4: dev 0 word 62 [0]
> ata4: dev 0 configured for UDMA/33

Word 62 is also zero on my JMicron 20330 bridge.
Since JMicron doesn't need the DMA DIR bit, it looks consistent
(maybe by coincidence) with the ATA-7 spec.

For SiI 3611, it was made before the ATA-7 spec is finalized. So, it is
reasonable that SiI 3611 doesn't implement word 62 and we have to 
manually enable the DMA DIR support as work around unless SiImage provides
other solution to identify the SiI 3611 bridge.

Thanks for the test result. :)
--
albert





