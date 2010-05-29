From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] libata-sff: trivial corrections to Kconfig help text
Date: Sat, 29 May 2010 17:41:51 +0200
Message-ID: <4C0135BF.1010505@s5r6.in-berlin.de>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de> <4C010AA8.8070004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:53689 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab0E2Prr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 May 2010 11:47:47 -0400
In-Reply-To: <4C010AA8.8070004@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> On 05/29/2010 12:47 PM, Stefan Richter wrote:
>> By the way, is there something that could be said in a few words in the
>> help text when to enable that option and when not?
> 
> Hmmmm... maybe we can emphasize the 'if unsure, say Y' part?

I did follow that recommendation but was still left curious. :-)

>> Or could that option even be hidden and 'select'ed by bus master DMA
>> capable ATA SFF drivers?
> 
> I wanted to make the distinction clear so made the option explicit.
> Opinions on whether that is actually a good idea would differ but at
> the same time, I don't think this would cause any problem, would it?

OK, I first came across it by way of make oldconfig.  Then I read the
changelog and still wondered.  Now I had a look at the menu layout in
gconfig and it makes sense to me now.

Just from the looks of the menu, would calling the prompt

	bool "SFF controllers with bus master DMA"

be sensible?  After all, this option does not just control whether a
certain capability is built into libata, switching it on pulls up the
Kconfig prompts for a whole range of controller drivers.  (Ok, the help
text is saying exactly this, but then the prompt could do so already...)

The 'hidden variable + select' way would be more friendly to "make
oldconfig", but I see now that it would take quite a few select
statements to be added.
-- 
Stefan Richter
-=====-==-=- -=-= ===-=
http://arcgraph.de/sr/
