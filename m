From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: trivial corrections to Kconfig help text
Date: Sun, 30 May 2010 10:46:09 +0200
Message-ID: <4C0225D1.90205@kernel.org>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de> <4C010AA8.8070004@kernel.org> <4C0135BF.1010505@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46543 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab0E3Iqa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 May 2010 04:46:30 -0400
In-Reply-To: <4C0135BF.1010505@s5r6.in-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hello,

On 05/29/2010 05:41 PM, Stefan Richter wrote:
>> Hmmmm... maybe we can emphasize the 'if unsure, say Y' part?
> 
> I did follow that recommendation but was still left curious. :-)

Maybe it should be changed to "You're supposed to be unsure, say Y,
dammit!" :-)

>>> Or could that option even be hidden and 'select'ed by bus master DMA
>>> capable ATA SFF drivers?
>>
>> I wanted to make the distinction clear so made the option explicit.
>> Opinions on whether that is actually a good idea would differ but at
>> the same time, I don't think this would cause any problem, would it?
> 
> OK, I first came across it by way of make oldconfig.  Then I read the
> changelog and still wondered.  Now I had a look at the menu layout in
> gconfig and it makes sense to me now.
> 
> Just from the looks of the menu, would calling the prompt
> 
> 	bool "SFF controllers with bus master DMA"
> 
> be sensible?  After all, this option does not just control whether a
> certain capability is built into libata, switching it on pulls up the
> Kconfig prompts for a whole range of controller drivers.  (Ok, the help
> text is saying exactly this, but then the prompt could do so already...)

Yes, sure.  Can you please combine this with the original patch?

> The 'hidden variable + select' way would be more friendly to "make
> oldconfig", but I see now that it would take quite a few select
> statements to be added.

Yeah, that and I *really* wanted to make the distinction explicit
because ambiguous dependeny has been a problem for some time.  Now a
driver will end up in a different config section which is always
visible depending on its dependencies, so I like this much better.

Thanks.

-- 
tejun
