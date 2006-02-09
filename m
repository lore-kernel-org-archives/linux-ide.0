From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Thu, 09 Feb 2006 04:21:29 -0500
Message-ID: <43EB0999.9060204@pobox.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AFEF.4010909@gmail.com> <43EAB5BA.3050204@tw.ibm.com> <43EABDFB.8000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8350 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030191AbWBIJVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:21:33 -0500
In-Reply-To: <43EABDFB.8000505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Tejun Heo wrote:
> Hello, Albert.
> 
> Albert Lee wrote:
> 
>>>
>>> This is sort of OT, but would it be possible to separate PIO
>>> issuing/interrupt handling from ata_qc_issue_prot and ata_host_intr?
>>>
>>
>> Isn't overriding the ->qc_issue() and ->irq_handle() in LLDD good enough?
> 
> 
> The driver needs its own ->qc_issue() and ->irq_handler() but it also 
> needs PIO support.  AFAICS, the current PIO implementation is rather 
> strongly tied into ata_qc_issue_prot() and ata_host_intr() making it 
> difficult to use PIO support in drivers which use private ->qc_issue() 
> and ->irq_handler().  So, what I was asking was to separate out PIO 
> handling from ata_qc_issue_prot() and ata_host_intr() such that other 
> issue and intr routines can use PIO.

What needs this separation?  initio?


> Separating out traditional driving logic from libata-core.c would 
> require another level of indirection such that traditional low level 
> drivers still can mix & match different legacy operations.  I thought 
> about it and wasn't really sure whether the added abstraction was worth 
> the clean up.  We currently don't have too many controllers which are 
> legacy-free, it seems.

IMO the solution is time.  Time and evolution will determine what's 
best.  When a particular section of code get particularly large (PCI IDE 
driver helper code), it certainly makes sense to split it out.  "Do what 
you must, and no more" is the Linux maxim :)

	Jeff


