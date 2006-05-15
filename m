From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 13:13:30 -0400
Message-ID: <4468B6BA.3080405@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <1147713568.26686.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964991AbWEORNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 13:13:33 -0400
In-Reply-To: <1147713568.26686.79.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Alan Cox wrote:
> On Llu, 2006-05-15 at 13:00 -0400, Jeff Garzik wrote:
>> * PIO-based I/O is now IRQ-driven by default, rather than polled
>>   in a kernel thread.  The polling path will continue to exist for
>>   controllers that need it, and other special cases. (Albert Lee)
> 
> How will this be selected ? Passing ->irq = 0 ?

It is selected at runtime by passing a polling flag to ata_taskfile.

That flag, in turn can be set by anything -- driver flags (for 
controllers that always require polling), user variable requested at 
runtime, whatever.


> For ata_piix given you've destabilized it a bit would now be a good time
> to submit the patches to fix the timing, register scribble and incorrect
> ATAPI caching ?

Sure.

	Jeff


