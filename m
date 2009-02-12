From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 22:28:45 -0600
Message-ID: <4993A57D.6010107@gmail.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca> <49934D24.1050204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:50038 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbZBLE2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 23:28:51 -0500
Received: by rn-out-0910.google.com with SMTP id k40so604403rnd.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 20:28:49 -0800 (PST)
In-Reply-To: <49934D24.1050204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Chuck Ebbert <cebbert@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> I wonder if it's just a case of too short a timeout on the cache flushes?
> 
> The answer in general to this question has always been "yes".....
> 
> Unless this has changed in the past year, the worst case for SATA cache 
> flush can definitely exceed 30 seconds...  it is unbounded as defined in 
> the spec, and unbounded in practice as well.
> 
> Of course, users' patience is not unbounded :)

Yeah, it's pretty ludicrous for a cache flush to potentially take that 
long. Theoretically if you had a 32MB write cache completely full with 
completely non-contiguous sectors you could end up with it taking 
something like 2 minutes or more to write out. However, the drive really 
should be ensuring that it doesn't build up so much in the write cache 
that a flush would takes this long - that is a lot of data that could be 
lost on an unexpected power-off.

However, in this case the drive is not reporting Busy status at the 
timeout, which suggests maybe an interrupt got lost or something. (Could 
be still the drive's fault.)

Chuck, when this happens can you tell if the disk sounds like it is 
grinding away until the timeout happens or is it just sitting there?
