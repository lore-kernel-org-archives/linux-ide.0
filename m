From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 20:51:26 -0400
Message-ID: <4478F40E.2000402@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca> <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:17342 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751577AbWE1Av2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:51:28 -0400
In-Reply-To: <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 27 May 2006, Mark Lord wrote:
>> So, just the "status1 = ata_chk_status(ap);" seems to be enough
>> to make it work for you, in place of the earlier 500msec delay we started
>> with?
> 
> Not possible, since the "ata_busy_wait()" already did at least _one_
> 
> 	udelay(10);
> 	status = ata_chk_status(ap);
> 
> as part of the busy wait. So it's not just a single ata_chk_status() that 
> matters for Jens, it's a couple. And apparently waiting for DRDY actually
> works for him.
...
> If I've understood correctly, this patch (with no additional timeouts or 
> anything else) should work for both Mark and Jens, and not make Jeff's 
> case noticeably worse either. And I'm certainly fine with it.
..
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
> +	/*
> +	 * Wait for BUSY to go away for up to 2 seconds,
> +	 * and then try to wait for idle (up to 1 msec)
> +	 */
> +	ata_busy_wait(ap, ATA_BUSY, 200000);
> +	ata_wait_idle(ap);
> +	
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);
..

It works for me.  But I really think we need to hear from Jens,
as his machine seems the more finicky.  As you pointed out,
his works only with a small delay in front of the previous patches,
and that small delay may still be needed here..

If Zhao is still "on the line", perhaps he could also comment
for his own setup, though the above patch should certainly work
(the original patch from me was really a quick backport of his patch).

Cheers
