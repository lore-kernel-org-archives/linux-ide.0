From: Tejun Heo <htejun@gmail.com>
Subject: Re: Frequent SATA errors / port timeouts in 2.6.18.3?
Date: Wed, 20 Dec 2006 09:42:47 +0900
Message-ID: <45888707.4010803@gmail.com>
References: <4578F5D4.8080205@moniker.net> <4580907D.1020407@ucolick.org> <4587903C.3050204@gmail.com> <4588847E.3090303@ucolick.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:40715 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbWLTAmy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 19:42:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so796247nze
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 16:42:53 -0800 (PST)
In-Reply-To: <4588847E.3090303@ucolick.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrik Jonsson <patrik@ucolick.org>
Cc: linux-ide@vger.kernel.org

Patrik Jonsson wrote:
> At the time it happened, none of the devices responded to smart commands
> ("not an ATA device"). After resetting, they do. The outputs are at the
> bottom.

Hmmm... Nothing indicative of power problem.  The first drive seems to
have suffered quite some number of read failures due to bad sectors tho.

>>> The drives contain science data for analysis, so it
>>> would be a pain (though not a disaster) to lose it. Would it be
>>> advisable to revert to the previous 2.6.17 that I was running before or
>>> is this a problem that's fixed in a later kernel than the one I'm
>>> running now?
>>>
>>> I did at the same time also install an Areca ARC1260 controller and
>>> connected a bunch of drives to it, so another idea I had was cable
>>> interference or something (there are now 18 drives in the machine).
>>>
>>> Any ideas or thought would be appreciated,
>> Power quality degradation can cause transmission failures which can
>> result in timeouts.  How are your power lines hooked?
> 
> The drives are connected to the Seasonic M12-600 PSU, connected to an
> APC BackUPS and then it's in the wall. It's in a dedicated computer
> room, but I'm not sure if the power in conditioned in any way.

My primary suspect is still power.  Please do one of the followings.

* Buy an extra power and hang 2/3 of drives there.  Just cheap 350w one
should do.  Using PS without mainboard attached is easy, google it.  In
my experience, single-lane 300 ~ 350w PS is better than 450w multilane
one for this purpose.  More juice on molex/SATA 12v.

* If that's not an option, disconnect the extra drives and see how the
system behaves.

-- 
tejun
