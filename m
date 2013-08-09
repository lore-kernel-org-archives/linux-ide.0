From: DeadManMoving <sequel@neofreak.org>
Subject: Re: SATA PMP issue
Date: Fri, 09 Aug 2013 15:50:45 -0400
Message-ID: <1376077845.3607.10.camel@lappy.neofreak.org>
References: <1375891867.3607.8.camel@lappy.neofreak.org>
	 <20130809143033.GI20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out.neofreak.org ([69.165.217.67]:59264 "EHLO
	vortex.neofreak.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030908Ab3HITvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 15:51:01 -0400
In-Reply-To: <20130809143033.GI20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Mister Heo,

first, thank you so much to have taken the time to answer.

I sure can understand your point, i have spent some time too see what
was supported and what was not and finally, i have equipments that looks
like are not working together.

But on the other hand, it is not easy to try to stick to known working
configurations since, from what i have seen, the chip inside enclosures
are rarely exposed to consumer.

It will probably changes nothing but, i am pretty sure now that this is
not an hardware incompatibility since, i have spent some time yesterday,
doing a FreeBSD install on a spare disk, in one of my computer with the
Marvell 88SE9120 controller and, when i hooked up the Mediasonic
enclosure (which, i finally found out is using a JMicron JMB393 chip
(0x197b:0x0325)), i was able to see all four drives without any issue
(with the FreeBSD ahci driver of course).


Best regards,

Tony

On Fri, 2013-08-09 at 10:30 -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 07, 2013 at 12:11:07PM -0400, DeadManMoving wrote:
> > i am unable to get SATA port multiplier to work between a Marvell SATA
> > 88SE9120 CARD (HighPoint Rocket 622A) and four disks within a Mediasonic
> > HF2-SU3S2 enclosure.
> > 
> > Howerver, the Mediasonic enclosure is working with a SiI 3132 controller
> > (i can see all four disks) and also, i have a Thermaltake BlacX Duet
> > which is working on the 88SE9120 (i can see both disks).
> > 
> > Here is what the kernel have to say when i try to get the 88SE9120 to
> > work with the Mediasonic enclosure :
> 
> Unfortunately, I kinda gave up on PMP / controller compatibility
> issues and it seems like most vendors have given up on PMPs too.
> After the first gen chips, nobody is really working on it, and the
> first gen chips of course are full of quirks and bugs.  At this point,
> I'd generally recommend against using PMPs and if you really want to
> stick to known working configurations.
> 
> Sorry.
> 

