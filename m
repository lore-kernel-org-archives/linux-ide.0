From: Ric Wheeler <ric@emc.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 07:12:47 -0500
Message-ID: <43DA0E3F.7000507@emc.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org> <20060126092120.GP4212@suse.de> <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org> <20060127081319.GU4311@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:27598 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932487AbWA0MSB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 07:18:01 -0500
In-Reply-To: <20060127081319.GU4311@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

Jens Axboe wrote:

>On Thu, Jan 26 2006, Nicolas Mailhot wrote:
>  
>
>>
>>I applied the fua backout patch and the kernel booted beautifully.
>>Now I guess I need to see if Maxtor released a fixed firmware right ?
>>(is it possible to change the firmware on a running system ?)
>>    
>>
>
>If you can get an update firmware, it is usually done by booting from
>DOS floppy and running a special flash utility from there. Can you send
>me the hdparm -I /dev/sdX output of the problem drive? I think we should
>just blacklist it for FUA. This bug is so obscure I think it's a better
>solution than adding a FUA disable module parameter at this point.
>
>  
>
I am not sure that drive vendors support firmware upgrades - the 
downside is that you can produce a nice paper weight if the firmware 
upgrade fails ;-)

Also, there are specific versions where I know that you cannot jump from 
firmware version X to version X + 1. 

ric

