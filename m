From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] libata: turn on the ATAPI DMADIR support per word
 62 (revised)
Date: Thu, 20 Apr 2006 18:51:13 -0400
Message-ID: <44481061.30902@garzik.org>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com> <44360B05.6050509@garzik.org> <44363D2E.7010700@tw.ibm.com> <4436431C.8070800@tw.ibm.com> <4436A770.70107@garzik.org> <44446C6C.702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16031 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932109AbWDTWvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 18:51:17 -0400
In-Reply-To: <44446C6C.702@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Albert Lee wrote:
> Summary:
>   SiI 3611 is currently the only known chip that needs DMADIR.
> Since SiI 3611 doesn't implement the ATA-7 word 62 or mangle identify
> packet device data, it's hard to check the chip and turn on the DMADIR
> support automatically. (Currently the libata DMADIR support can be 
> turned on manually by module parameter.)

Wonderful test report, thanks a _bunch_ for investigating this.


> To turn on the DMADIR support automatically, maybe we can check whether
> the ATAPI device is bridged (by ata_dev_knobble()). If bridged, we can
> try to issue a ATAPI DMA read command to check if ATAPI DMA works.
> If not work, then try turning on DMADIR or turn off ATAPI DMA.

Sounds like more complexity than its worth, for one non-spec-compliant 
bridge chip.  The module option gets the 3611 going, so IMO the current 
level of support is adequate.

BTW, I found a 3611 here, and put it into my primary fileserver, 
attaching to a DMA-capable PATA CD-RW drive.

	Jeff


