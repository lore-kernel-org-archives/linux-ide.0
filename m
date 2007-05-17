From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Thu, 17 May 2007 11:18:26 +0200
Message-ID: <464C1DE2.8080501@gmail.com>
References: <1179232945.16527.25.camel@quest.netsplit.com>	 <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com>	 <1179243992.16527.56.camel@quest.netsplit.com> <464AE0EB.9080300@gmail.com> <1179317806.16527.73.camel@quest.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:63687 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbXEQJS5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 05:18:57 -0400
Received: by nz-out-0506.google.com with SMTP id r28so882022nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 02:18:55 -0700 (PDT)
In-Reply-To: <1179317806.16527.73.camel@quest.netsplit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: linux-ide@vger.kernel.org, 114683@bugs.launchpad.net

Scott James Remnant wrote:
> On Wed, 2007-05-16 at 12:46 +0200, Tejun Heo wrote:
> 
>>> I'll keep an eye on the thread you linked to, if we don't even need to
>>> write any zeros, we're definitely happy people :-)
>> Me happy too.  :-)
>>
> Out of interest, do you know there is a hysterical need to sync() before
> one calls reboot()?
> 
> I would have thought the kernel takes care of making sure it's own data
> structures are flushed to disk anyway, but I can't see the reference in
> the kernel code for where it might do this.

I dunno.  I seem to recall there was discussion about disk driver not
flushing cache or something like that years ago but I could be imagining
things.  With recent kernels, there's no reason for userland to do that
before shutting down.  Kernel always flushes caches during shutdown, but
we can also afford some paranoia there as that doesn't cause any harm.

-- 
tejun
