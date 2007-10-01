From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Mon, 01 Oct 2007 09:31:42 -0400
Message-ID: <4700F6BE.3060904@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FDE1A7.6030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46822 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbXJANbq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 09:31:46 -0400
In-Reply-To: <46FDE1A7.6030102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Polling ALREADY makes the job of fixing SAS/SATA exception handling
>> difficult.  Expanding polling to something SAS/SATA controllers treat as
>> fundamentally irq-driven and integrated with the rest of the command
>> flow is moving in the wrong direction.
>>
>> To re-re-re-summarize, polling in PMP is fundamentally broken for an
>> ENTIRE CLASS OF HARDWARE that we actively support today.  And
>> jgarzik/misc-2.6.git#sas is adding two more controllers to that list.
> 
> As an interim solution, it doesn't make anything worse tho.  Those
> drivers don't support PMP anyway.  After rc1 merge, polling PMP access
> can be replaced with new qc_issue (probably ata_exec_internal) based code.
> 
> The question here is whether it's worth to include PMP support with
> polling PMP register access as an interim solution for 2.6.24.  I think
> it will be beneficial for both user convenience and testing as long as
> the said change is made soon after -rc1.

Polling PMP 2.6.24 is completely unacceptable.  It screws the 2.6.24 SAS 
driver releases out of PMP.

I pulled your last PMP patchset, and will now endeavor to fix the API 
prior to 2.6.24 merge window opening.

Linux high level message-submit / message-complete APIs should never 
_require_ polling, even if its 100% polling under the hood.  There are 
far too many cases in the field where you don't have direct access to 
hardware registers to poll.  Or such polling would interfere with the 
operation of other ports.  Or any of a myriad of other reasons.

	Jeff



