From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA PMP issue
Date: Fri, 9 Aug 2013 10:30:33 -0400
Message-ID: <20130809143033.GI20515@mtj.dyndns.org>
References: <1375891867.3607.8.camel@lappy.neofreak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:34230 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243Ab3HIOai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:30:38 -0400
Received: by mail-qa0-f49.google.com with SMTP id cr7so935692qab.1
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:30:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375891867.3607.8.camel@lappy.neofreak.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: DeadManMoving <sequel@neofreak.org>
Cc: linux-ide@vger.kernel.org

Hello,

On Wed, Aug 07, 2013 at 12:11:07PM -0400, DeadManMoving wrote:
> i am unable to get SATA port multiplier to work between a Marvell SATA
> 88SE9120 CARD (HighPoint Rocket 622A) and four disks within a Mediasonic
> HF2-SU3S2 enclosure.
> 
> Howerver, the Mediasonic enclosure is working with a SiI 3132 controller
> (i can see all four disks) and also, i have a Thermaltake BlacX Duet
> which is working on the 88SE9120 (i can see both disks).
> 
> Here is what the kernel have to say when i try to get the 88SE9120 to
> work with the Mediasonic enclosure :

Unfortunately, I kinda gave up on PMP / controller compatibility
issues and it seems like most vendors have given up on PMPs too.
After the first gen chips, nobody is really working on it, and the
first gen chips of course are full of quirks and bugs.  At this point,
I'd generally recommend against using PMPs and if you really want to
stick to known working configurations.

Sorry.

-- 
tejun
