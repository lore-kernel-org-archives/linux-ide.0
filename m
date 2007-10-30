From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly compatible
 emulations
Date: Tue, 30 Oct 2007 09:39:16 -0400
Message-ID: <47273404.40802@garzik.org>
References: <20071025142116.7e38ee86@the-village.bc.nu>	<47273128.4090406@garzik.org> <20071030133350.687a5360@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38546 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbXJ3NjU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 09:39:20 -0400
In-Reply-To: <20071030133350.687a5360@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> The other IT821x change is a bit ugly, we slightly abuse the cable type
>>> hook to fiddle with the identify data for the devices. We could add a new
>>> hook for this but as we have only one offender and no more seeming likely
>>> it seems better to keep libata-core clean.
>>>
>>> Please let this sit in -mm briefly, just in case the relaxed checking
>>> breaks some other emulated interface.
>>>
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>> Two questions:
>>
>> 1) should I queue for 2.6.24-rc?
> 
> Can we leave it once cycle in -mm and aim for 2.6.25-rc. There is a tiny
> possibility we will find someone who finds slave returning 0 produces a
> ghost drive or decode problem. Probably paranoia.

into #for-testing it goes


>> 2) why is ->dev_config() insufficient?
> 
> It is called (I think correctly) after we have performed identify
> dependant actions including HPA sizing.

hmmmm.  It certainly seems like we should have a hook that permits 
touching up dev->id[] before we go through all the actions based on 
IDENTIFY DEVICE results.

It sounds like such a hook would be more appropriate here...  can you 
think of any other situation or driver that could make use of a 
pre-dev-config hook?

	Jeff


