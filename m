From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Sat, 13 May 2006 19:20:36 +0900
Message-ID: <4465B2F4.3040208@gmail.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com> <44653807.3030101@gmail.com> <44655496.9030402@pobox.com> <44655986.3060007@gmail.com> <4465AEC0.30300@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:28251 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932100AbWEMKUp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 06:20:45 -0400
Received: by wr-out-0506.google.com with SMTP id i22so665964wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 03:20:44 -0700 (PDT)
In-Reply-To: <4465AEC0.30300@stesmi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Stefan Smietanowski wrote:
>> Which is understandable considering AHCI doesn't construct FISes itself.
>>  I don't think PM requires more hardware support than being capable for
>> setting PMP in the FISes, which AHCI certainly can (standing down on
>> collision for SDB notify aside).  I can give it a shot but it clearly
>> violates the spec, and even if it works, we would need to print big fat
>> warning message while attaching PM.
>>
> 
> Are you saying that the next big thing since sliced bread (AHCI) that's
> supposed to unite the world and make everybody sing Kumbayah doesn't
> support port multipliers (according to the spec) ?
> 
> Or am I totally misreading this.

Heh heh.

I love AHCI too, but as far as PMS is concerned, AHCI is not saving any 
world.  There's a bit called SPM (supports Port Multiplier) in the 
capability register.  If the bit is set, AHCI support PM by 
command-based switching, which ummm... sucks - only one device can have 
active commands at any given time.  AHCI v1.1 (the current spec) lists 
FIS-based switching PMS as 'to be specified in a future AHCI specification'.

To make matters worse, not many AHCI controllers seem to have that bit 
set.  My ICH7R (P5LD2) doesn't and I would be surprised if any of 
ICH6R/M and ICH7M have that bit set.  Zhao reported that ESB2 (server 
chipset w/ 6 SATA ports) have that bit set, so there are some 
controllers supporting PM out there.

However, cmd-switching PMS doesn't require much support from HBA, and I 
don't see why my ICH7R cannot do PMS.  I'm currently giving it a try now.

So, ATM, if you want PMS, sil3124/3132 series is the best choice.

-- 
tejun
