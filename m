From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 19:23:24 -0500
Message-ID: <4D532FFC.2020503@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>	<4D5306F8.6050106@cfl.rr.com> <20110209213904.4aff945d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44824 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab1BJAX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 19:23:26 -0500
In-Reply-To: <20110209213904.4aff945d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 02/09/2011 04:39 PM, Alan Cox wrote:
> The old IDE driver defaulted to unlocking based upon years of experience
> in the real world. Jeff insisted on being different, and surprise
> surprise everyone ended up setting distro defaults that were different.

What experience?  The only reason that I have heard for unlocking it is 
to maintain compatibility with the old ide driver which did so.  What 
reason does Linux have to access an area of the disk that the system has 
made clear it should not?  Aside from the upgrade case, I can not see 
any upside to this, only the downside of breaking on systems that work 
fine on Windows, because it does not disregard the platform request to 
leave that part of the disk alone.

>> The discussion at hand is about a change made a few months ago that is a
>> good compromise between always unlocking, and never unlocking.  Both of
>> those have problems, so a good compromise can have the benefits of both,
>> and the drawbacks of neither.  Furthermore, it is already in the kernel,
>> so continuing to argue about whether it should have been done or not
>> seems a moot point.

> I disagree, and again you are still missing the entire point. For the
> RAID stuff you don't care if we unlock, you don't need to care if we
> unlock. You need to care about getting the raid tools figuring out what
> geometry the raid creation was using.

What part to you disagree with?  That the compromise in place can have 
the benefits of both, but the drawbacks of neither?

I understand that dmraid could work around the problem, but there should 
not be a problem in the first place.  The system has asked that we not 
touch that part of the disk, so unless we have a good reason to do 
otherwise, we should honor that request.  Given that this is how the 
kernel has operated for years, I am surprised that we are rehashing this 
argument.  The other side of the argument that some distributions have 
settled on seems to be satisfied with the compromise of auto unlock iff 
a partition seems to use the protected space.

You seem to be saying that this compromise should not have gone into the 
kernel and instead, it should have just been patched to always unlock 
like some distributions have.  Why?  What advantage is there to always 
unlocking over auto unlocking only when it seems necessary?

