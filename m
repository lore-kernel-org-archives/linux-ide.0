From: Ric Wheeler <ric@emc.com>
Subject: Re: Problem with disk
Date: Sat, 13 May 2006 15:31:57 -0400
Message-ID: <4466342D.3030905@emc.com>
References: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca> <445D29A1.5000402@gmail.com> <445DF445.6070803@emc.com> <445DF911.1020408@gmail.com> <445F56B2.9070300@emc.com> <44626769.2000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:37812 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750706AbWEMTcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 15:32:01 -0400
In-Reply-To: <44626769.2000601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, David.Ronis@McGill.CA, linux-ide@vger.kernel.org, neilb@suse.de



Tejun Heo wrote:

> Ric Wheeler wrote:
>
>> I think that MD will do the right thing if the IO terminates with an 
>> error condition.  If the error is silent (and that can happen during 
>> a write), then it clearly cannot recover.
>
>
> The condition I've described results in silent loss of data.  
> Depending on type and implementation, LLDD might be able to detect the 
> condition (PHY RDY status changed for SATA), but the event happens 
> after the affected writes are completed successfully.  For example,
>
> 1. fs issues writes for block #x, #y and then barrier #b.
> 2. #x gets written to the write-back cache and completed successfully
> 3. power glitch occurs while #y is in progress.  LLDD detects the 
> condition, recovers the drive and retries #y.
> 4. #y gets written to the write-back cache and completed successfully
> 4. barrier #b gets executed and #y gets written to the media, but #x 
> is lost and nobody knows about it.

The promise that you get from the barrier is pretty simple - after a 
successful one, all IO's that have been submitted before then are on 
platter if the barrier works.

In your example, if you mean power glitch as in power loss, x will be 
lost (and probably lots of other write cache state), but the application 
should expect it (or add extra barriers)....

>
> I'm worried about the problem because, with libata, hotplug is 
> becoming available to the masses and when average Joe hot plugs a new 
> drive into his machine which has $8 power supply (really, they sell 
> 300w ATX power at 8000 KRW which is about $8), this is going to 
> happen.  I had a pretty decent power supply from a reputable maker but 
> I still got hit by the problem.

Not sure that I understand exactly how a glitch (as opposed to a full 
loss) would cause x to get lost - the drive firmware should track the 
fact that x was in the write cache and not destaged to platter.

>
> Maybe the correct approach is to establish a warm-plug protocol.  
> Kernel provides a way to plug IOs and user helper program plugs all 
> IOs until the new device settles.
>
> Thanks.
>
