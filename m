From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 21:43:53 -0400
Message-ID: <46FDADD9.9050007@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50210 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbXI2Bn5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 21:43:57 -0400
In-Reply-To: <20070928220309.7c9ed816@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> Jeff, seeing as Tejun's commitment is never in doubt here,
>> I really believe we should go with the existing PMP patchset
>> for 2.6.24 (unless the respin happens quickly enough).
>>
>> This functionality is way overdue, and we shouldn't be impeding it
>> as long as we have been.
> 
> I would second this. Its far too important to not get this stuff upstream
> and usable NOW. Yes the model will have to change a bit but the entire
> libata today has almost no resemblence to the one a year ago.
> 
> It can evolve and then the old one can die off just as we did with EH
> (except for libsas anyway)

I certainly deserve plenty of blame for not catching this fact earlier, 
much to my chagrin.  But there are real technical issues at hand:

Polling ALREADY makes the job of fixing SAS/SATA exception handling 
difficult.  Expanding polling to something SAS/SATA controllers treat as 
fundamentally irq-driven and integrated with the rest of the command 
flow is moving in the wrong direction.

To re-re-re-summarize, polling in PMP is fundamentally broken for an 
ENTIRE CLASS OF HARDWARE that we actively support today.  And 
jgarzik/misc-2.6.git#sas is adding two more controllers to that list.

	Jeff



