From: Mark Lord <lkml@rtr.ca>
Subject: Re: Merging libata PATA support into the base kernel
Date: Fri, 11 Aug 2006 11:48:36 -0400
Message-ID: <44DCA6D4.7090304@rtr.ca>
References: <1155144599.5729.226.camel@localhost.localdomain> <p733bc5nm5g.fsf@verdi.suse.de> <1155213464.22922.6.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex> <20060810194734.GE11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:9447 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932156AbWHKPsm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2006 11:48:42 -0400
In-Reply-To: <20060810194734.GE11829@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jason Lunz <lunz@falooley.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jens Axboe wrote:
>
> I'm not on any of the suspend lists, I was merely comparing the
> suspend-others or suspend-libata ration to suspend-ide on linux-kernel,
> and the latter is clearly in the minority. I've used ide suspend quite a
> bit myself, and never had issues with it (or whichever ones I saw
> initially, I fixed). Of course it depends very much on the hardware. I'd
> still say that ide suspend probably supports a much wider range of
> hardware, than does libata suspend.

Of my various notebooks over the years that used drivers/ide,
all of them work/worked perfectly with suspend/resume to RAM.

Just luck, perhaps.

Cheers
