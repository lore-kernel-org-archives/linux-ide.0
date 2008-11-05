From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Wed, 05 Nov 2008 11:23:07 +0900
Message-ID: <4911038B.9020003@kernel.org>
References: <20081104062734.GA4420@havoc.gtf.org> <alpine.LFD.2.00.0811040823350.3419@nehalem.linux-foundation.org> <20081104203036.GE5862@ucw.cz> <alpine.LFD.2.00.0811041307030.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32926 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbYKECXW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 21:23:22 -0500
In-Reply-To: <alpine.LFD.2.00.0811041307030.3419@nehalem.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@suse.cz>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> 
> On Tue, 4 Nov 2008, Pavel Machek wrote:
>> (Is park command normally supported on modern disks? IIRC hdaps people
>> had issues with not all disks supporting it?)
> 
> The modern version of parking is called "idle immediate". It may be that 
> only laptop drives support the "unload" part. But it's definitely not an 
> ancient and deprecated thing (although calling it "parking" is apparently 
> old-fashioned :)

I'm afraid trying to use that new extension during shutdown would cause
far more trouble which would require extensive black/white list at the
end.  For hdaps, it's okay as the laptops w/ those sensors are supposed
to have matching hard drive but using it on generic machines doesn't
sound like a sane idea.

Thanks.

-- 
tejun
