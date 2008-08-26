From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv (NOT!)
Date: Tue, 26 Aug 2008 10:14:43 -0400
Message-ID: <48B40FD3.5040009@rtr.ca>
References: <48A0C170.2000803@verizon.net> <48A307D3.2000905@rtr.ca> <48ABA997.1050109@verizon.net> <48ADE68D.20705@rtr.ca> <48AE4BCE.8090401@garzik.org> <48B4092E.3050907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58861 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024AbYHZOOo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 10:14:44 -0400
In-Reply-To: <48B4092E.3050907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Steven Gill <smgill75@verizon.net>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>>
>>> Yeah, it looks to me as if libata still has DVD burner issues.
>>> I used my SATA DVDRW drive to burn a Suse DVD the other day,
>>> and the same drive refused to read the burnt disc without first 
>>> rebooting.
>>>
>>> linux-2.6.25.6
>>>
>>> Disc was fine, though.  Single-layer.
>>
>> Do you get error messages as well?  Of what kind?
> ..
> 
> There have been so many broken things in so many parts of the kernel of 
> late,
> that I'm just way too far behind in diagnosing/fixing them.   Or 
> reporting them,
> since many developers have stated they would rather not see a bug report
> without a bisect.
> 
> But here's all that was in the logs for this particular bug.
> These messages appeared when trying to read the freshly burned DVD,
> both before and after eject/reinsert.  A reboot cured it:
> 
> [ 8209.473181] attempt to access beyond end of device
> [ 8209.473189] sr0: rw=0, want=68, limit=4
> [ 8209.487646] attempt to access beyond end of device
> [ 8209.487655] sr0: rw=0, want=5480256, limit=4
..
> [ 8209.514467] attempt to access beyond end of device
> [ 8209.514467] sr0: rw=0, want=68, limit=4
> [ 8209.514467] isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
..

To hazard a guess at the problem here, I'd say that perhaps the media change
went undetected, and so sr_media_change() never got called.

I'm no longer even sure what would trigger that call.

Cheers

