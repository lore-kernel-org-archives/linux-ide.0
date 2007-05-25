From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 00:26:05 -0400
Message-ID: <4656655D.7070109@garzik.org>
References: <4656591A.6090701@garzik.org> <1180066312.32247.1098.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51226 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbXEYE0I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 00:26:08 -0400
In-Reply-To: <1180066312.32247.1098.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-05-24 at 23:33 -0400, Jeff Garzik wrote:
>> I moved the sil680 MMIO changes from 'upstream' (queued for 2.6.23) to
>> a 
>> side branch 'sil680-mmio'.
>>
>> To be clear, I am still quite interested in the patch (w/ the reset 
>> fix), but I did not want to delay other unrelated stuff that was
>> about 
>> to be queued into #upstream.
>>
>> The patch will still appear in -mm, and it is trivial to pull it from 
>> #sil680-mmio into #upstream once people are happy. 
> 
> Fine with me. I've been busy with other things and waiting for you and
> Alan to decide what should be done for the reset stuff anway :-)

Just replace the ata_std_softreset() call with code that does MMIO 
flushes on a safe register?


> So Alan, do you think we should add something or do you think that just
> reading altstat like ata_pause does is good enough ?

Reading AltStatus is fine for this.

	Jeff



