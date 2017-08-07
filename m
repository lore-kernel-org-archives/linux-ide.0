From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ata: make ata_port_operations const
Date: Mon, 07 Aug 2017 09:34:12 -0700
Message-ID: <1502123652.2219.24.camel@perches.com>
References: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
         <20170807150727.GD4050379@devbig577.frc2.facebook.com>
         <CAOH+1jEQy3PrExruDLWetVd=iWYX3sf13Ku5G5CUUbJGADsNvw@mail.gmail.com>
         <20170807162920.GA537256@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:47903 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751426AbdHGQeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2017 12:34:15 -0400
In-Reply-To: <20170807162920.GA537256@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-08-07 at 09:29 -0700, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 07, 2017 at 08:54:21PM +0530, Bhumika Goyal wrote:
> > I compiled the .o files and checked the size before and after
> > compilation. After making the structure const, bytes should move from
> > data to text segment of the memory and this is what happened. So, this
> > is how I tested it.
> 
> Ah, I see, so the port_operations is never used directly.  I'm not
> sure whether it'd be a good idea to selectively pick these and makr
> them const.  Let's just leave them be.

Why?

Things that are never accessed as other than const should
be const no?

Why leave unnecessary exposure for muckery?
