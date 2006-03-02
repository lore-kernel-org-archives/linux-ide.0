From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 01 Mar 2006 21:46:20 -0500
Message-ID: <44065C7C.6090509@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:5270 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750870AbWCBCq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 21:46:27 -0500
In-Reply-To: <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Eric D. Mudama wrote:
> On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>This also begs the question... what controller was being used, when the
>>single Maxtor device listed in the blacklist was added?  Perhaps it was
>>a problem with the controller, not the device.
>>
>>        Jeff
> 
> 
> As reported here:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951
> 
> the controller was a 3114, and the bug was "fixed" by blacklisting his
> Maxtor drive's FUA support.  I'd like Maxtor drives to be
> un-blacklisted if possible.

If its 3114 I agree un-blacklisting is the way to go... but its not 
clear to me whether the problematic configuration included sata_sil or 
sata_nv.  Since I'm apparently blind :) which part of the bug points 
conclusively to sata_sil?

	Jeff



