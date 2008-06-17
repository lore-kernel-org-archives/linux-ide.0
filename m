From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
 and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 21:27:47 +0900
Message-ID: <4857ADC3.3040106@kernel.org>
References: <4857313A.1000405@kernel.org>	<48573174.9050103@kernel.org>	<20080617094354.338e186b@lxorguk.ukuu.org.uk>	<48578080.5030605@kernel.org>	<20080617095439.GA9359@lukeross.name> <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42689 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbYFQMgW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2008 08:36:22 -0400
In-Reply-To: <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luke Ross <luke@lukeross.name>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> Originally the drive was bought for a different PC with a Silicon Image
>> 3114 controller. The drive worked fine with this (sata_sil). Then I
> 
> Ok that proves the point quite nicely. If there is a problem it is not
> the one suggested.

Yeah, indeed.  It's still weird tho.  The difference between
ATAPI_PROT_PIO and ATAPI_PROT_DMA is very small especially on ahci.  The
data are still transferred using the same FIS.  Only the completion
mechanism is different.  It would be great to try the drive on another
ahci controller preferably intel one.  Luke, do you have access to any
machine which has intel ahci?

-- 
tejun
