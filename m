From: Robert Hancock <rwh461@mail.usask.ca>
Subject: Re: [git patches] libata hibernation fixes
Date: Tue, 04 Nov 2008 18:20:29 -0600
Message-ID: <4910E6CD.9090605@mail.usask.ca>
References: <fa.Ast7pgG6P20u1PcyOsfgzoaX5YA@ifi.uio.no> <fa.1+JQHm7yjIiZJxAzR0eBPn39a9M@ifi.uio.no> <fa.8GbzH83c2CAI53n9dyzVOFugmoc@ifi.uio.no> <fa.hGdpNHQGmXAR19JiGuHxSr9N9CA@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:64019 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYKEAUe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 19:20:34 -0500
In-Reply-To: <fa.hGdpNHQGmXAR19JiGuHxSr9N9CA@ifi.uio.no>
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

IDLE IMMEDIATE just transitions the device to the Idle state, which is 
normally parked/unloaded and spun down. Newer specs have an unload 
option, but really the only thing that does is tell the drive to do it 
immediately, even if read-ahead is in progress or there is dirty data in 
its write cache (something we definitely don't want to do if we're about 
to power down), it still spins down.

It would be interesting to check Windows using QEMU or something to 
verify what exactly it's doing. I know Windows can run into this as 
well, on my Compaq X1000 laptop a shutdown from Windows also does a 
double spin-down on the hard drive. (However I replaced the original 
Hitachi drive with a Samsung, which might have different behavior.)
