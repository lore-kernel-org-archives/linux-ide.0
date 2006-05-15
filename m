From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 07:52:48 +0900
Message-ID: <44690640.2000407@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org> <4468D777.6080408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:55913 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750714AbWEOWwx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 18:52:53 -0400
Received: by wr-out-0506.google.com with SMTP id i32so992058wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 15:52:52 -0700 (PDT)
In-Reply-To: <4468D777.6080408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Andrew Morton wrote:
> ..
>>> http://bugzilla.kernel.org/show_bug.cgi?id=5586
>>
>> sata_mv still considered highly experimental, as noted in Kconfig.  
>> Bugs deferred to Mark Lord.
> ..
> I think that particular bug has gone away with my internal sata_mv.c 
> version.
> I'm updating it for release on top of Jeff/Tejun's patch set, and will 
> likely
> backport the bugfixes to 2.6.16.xx as well.  Timeline, this week or next.

The hotplug patches will change probing once more.  So, I recommend 
staying with legacy ->phy_reset mechanism for the time being unless you 
are using ->probe_reset() already.  However, converting from 
->probe_reset() to hotplug should be very easy.

-- 
tejun
