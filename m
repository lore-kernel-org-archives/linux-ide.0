From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 10:53:53 -0400
Message-ID: <47ED0681.4090003@emc.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBB09F.9070607@rtr.ca> <47EC5079.5020105@gmail.com> <47EC58F6.3070601@rtr.ca> <47ECF47A.2040508@emc.com> <47ED061F.2070701@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:50366 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbYC1O4r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 10:56:47 -0400
In-Reply-To: <47ED061F.2070701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> Ric Wheeler wrote:
>> I think that is a really important knob to have. Not just for RAID
>> systems, but we use the FLUSH_CACHE on systems without barriers mainly
>> when we power down & do the unmounts, etc.
>>
>> If you hit a bad block during power down of a laptop, I can image that
>> have a worst case of (30?) seconds is infinitely better than multiple
>> minutes ;-)
> 
> Fully finishing FLUSH CACHE requires command repetition.  Not fully
> finishing FLUSH CACHE on shutdown means sure data loss.  Given that
> FLUSH CACHE failure is very rare and it's repeatedly retried if and only
> if the device actively indicates failure, I'm not too sure.  Also note
> that if FLUSH CACHE fails, you cannot even trust the FS journal.  Things
> can get silently corrupt.
> 

I do agree with the above, we should try to get the FLUSH done according 
to spec, I meant to argue that we should bound the time spent. If my 
laptop spends more than 30? 60? 120? seconds trying to flush a write 
cache, I will probably be looking for a way to force it to power down ;-)

It is also worth noting that most users of ext3 run without barriers 
enabled (and the drive write cache enabled) which means that we test 
this corruption path on any non-UPS power failure.

ric

