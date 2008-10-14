From: Tejun Heo <tj@kernel.org>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 15:12:20 +0900
Message-ID: <48F43844.9080603@kernel.org>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>	<48F3D8E2.8000006@kernel.org>	<20081014070728.386a9cf2@mjolnir.drzeus.cx>	<48F43025.8050705@kernel.org> <20081014080304.65445c51@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38700 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYJNGPn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 02:15:43 -0400
In-Reply-To: <20081014080304.65445c51@mjolnir.drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Pierre Ossman wrote:
> On Tue, 14 Oct 2008 14:37:41 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
>> Pierre Ossman wrote:
>>> Bummer. Is this per port, or is it the PCIe side of the chip that is
>>> limited to this speed?
>> I think it's on the host bus side.
>>
>>> What do the silicon image guys have to say about it?
>> ISTR they confirmed the problem but I don't remember talking too much
>> about it.
>>
> 
> The optimist in me was hoping that this could be a problem that can be
> sidestepped with a clever enough implementation. :)
> 
>>>>  There's 3132-2 chip on the market.  Maybe it's worth a try?
>>> Now that model number was not something that was easily found on
>>> google, nor on silicon image's website. Know of any boards with that
>>> chip?
>> Somebody wrote me an email about it.  Looking up... eh.. can't find.  Sorry.
>>
> 
> Do you remember if that's a new chip designation, or 3132 (rev 02)?
> Just so I know what to keep an eye out for.

Yeah, it had a new designation.  Something like 3132-2 (don't confuse it
with 3132 2 ports or 3132 2 ports SATA 2, yeah a lot of 2s there).

-- 
tejun
