From: Ric Wheeler <ric@emc.com>
Subject: Re: Problem with disk
Date: Fri, 05 May 2006 20:51:14 -0400
Message-ID: <445BF302.4050709@emc.com>
References: <Pine.LNX.4.44.0605051939120.13704-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:53080 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751184AbWEFAur (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 May 2006 20:50:47 -0400
In-Reply-To: <Pine.LNX.4.44.0605051939120.13704-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: David.Ronis@McGill.CA, linux-ide@vger.kernel.org



Mark Hahn wrote:

>>I would suggest that you should run with the write cache disabled unless 
>>you can verify working barrier support.
>>    
>>
>
>this is true, but extremely conservative/paranoid.  it makes a lot 
>of sense if you're handling banking transactions or if you really
>see a lot of abrupt power-offs (yank the battery).  what are the chances
>of a drive failing to write dirty blocks when idle, halting?
>  
>
The write cache in modern drives is multiple megabytes - 8 or 16MB is 
not uncommon. The chances that you have data that is lost on a power 
failure in the write cache is actually quite high...

I agree that most people should not lose too much sleep over this.

>don't get me wrong: write barriers are A Good Thing.  just that Linux 
>survived very nicely for many years before such things were bothered with.
>
>  
>
>>The fact that your drive reports IO errors is also worrying - you might 
>>just have a bad drive...  You can look at drive help with tools like 
>>smartctl.
>>    
>>
>
>IO errors trump any concerns for write barriers - there's no need to 
>even think about barriers or cache settings if the disk is, for instance,
>reporting media errors...
>
>  
>
Agreed again ;-)

ric

