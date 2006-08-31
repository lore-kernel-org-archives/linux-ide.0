From: "Matt Reimer" <mattjreimer@gmail.com>
Subject: Re: Cache Coherency in PIO Read/Write
Date: Thu, 31 Aug 2006 12:10:50 -0700
Message-ID: <f383264b0608311210v7566747fu45d9c6ddbc6e69e3@mail.gmail.com>
References: <4D87F853B8020F4888896B1507DC0F09A2C433@mail2.netezza.com>
	 <44F72F15.40900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:5536 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932314AbWHaTKv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Aug 2006 15:10:51 -0400
Received: by wx-out-0506.google.com with SMTP id s14so709677wxc
        for <linux-ide@vger.kernel.org>; Thu, 31 Aug 2006 12:10:51 -0700 (PDT)
In-Reply-To: <44F72F15.40900@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mark Odell <modell@netezza.com>, linux-ide@vger.kernel.org

On 8/31/06, Mark Lord <liml@rtr.ca> wrote:
> Mark Odell wrote:
> > For PIO mode transfers, you should not have cache coherency issues since
> > the CPU core is doing the read from/write to hardware.
>
> One might think so, but cache lines are tagged with virtual addresses,
> so using different virtual addresses (kernel vs. userspace) for the
> same data can result in problems like this.
>
> There was a recent thread (this past winter, I believe) devoted to
> trying to resolve this issue in 2.6.xx, but I don't remember the final outcome.

http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=107384066503818&w=2
http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=107391014528541&w=2
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-May/022262.html
http://marc.theaimsgroup.com/?l=linux-ide&m=113517364630085&w=2
http://lkml.org/lkml/2006/1/13/156 and its associated posts

There are probably others. I think Tejun would know best the status of
this issue.

Matt
