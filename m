From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata atapi work #2.1
Date: Sun, 16 May 2004 19:20:55 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A7F757.9020200@pobox.com>
References: <1084721991.3085.6.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264854AbUEPXVI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 19:21:08 -0400
In-Reply-To: <1084721991.3085.6.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> I now see SATA stream up past 1.5 GB/min via ioctl SG_IO read & write of
> the disc blocks, after I apply together all four of the patches you
> first posted as:

Sounds like something is working...


>>Subject: [PATCH] libata update 20040515-1
>>Subject: [PATCH] libata atapi work #2.1
>>Subject: [PATCH] libata DMADIR support
>>Subject: [PATCH] Re: SATA ATAPI work in progress
> 
> 
> Heads up, I was myself slow to appreciate:
> 
> Yes still in -bk3 after patch.2.1 we need to apply that fourth patch
> i.e. what I had termed patch.7 i.e. ata_host_intr += ATA_PROT_ATAPI_DMA.

Please let me know what patches (if any besides #define) are needed for 
setup, after you include patch #2.2 and #2.3 in the pile.


>>Once I add the code to issue a REQUEST SENSE, ...
> 
> 
> Also, of course, to avoid dying for the lack of auto sense, I have to
> duck all errors.

Yes.

Two main things on the SCSI end of ATAPI to do:
* issue REQUEST SENSE, to simulate an auto-sensing scsi device
* in INQUIRY output, simulate compliance with MMC-3.  Linux SCSI stack 
is not aware that all ATAPI devices report zeroes in the SCSI version 
field (as do some USB storage devices).  So, we fake it.

	Jeff



