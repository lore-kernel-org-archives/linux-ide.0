From: Tejun Heo <tj@kernel.org>
Subject: Re: How to assess PMP register
Date: Sat, 09 May 2009 17:09:04 +0900
Message-ID: <4A053A20.60003@kernel.org>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>	 <49FA2763.9040409@rtr.ca>	 <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>	 <49FF7C2A.6030000@rtr.ca>	 <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com>	 <fa69d4570905082212y74242302o5bd8059ce358a4be@mail.gmail.com>	 <4A05121C.1040104@kernel.org> <fa69d4570905082323q3cf36a06xa28d035e2dafbafa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60130 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbZEIIJM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 May 2009 04:09:12 -0400
In-Reply-To: <fa69d4570905082323q3cf36a06xa28d035e2dafbafa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: s ticket <smticket@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

s ticket wrote:
>> The PMP access functions can only be called from EH context and that's
>> one of the reasons they aren't exported?  What are you trying to
>> achieve?
> 
> To driver some gpios on the PMP ;-).
> I tried to directly access the PMP and send ATA command from user space,
> but all failed.
> It seems there are no suitable way so far?

Hmm... the best way would be implementing an EH action for PMP r/w and
export it via ioctl or sysfs.  When invoked, it should schedule the EH
action and an EH handler should do actual IO and then get the result
back to the userland.  That would automatically solve synchronization
problem too.

-- 
tejun
