From: Tejun Heo <tj@kernel.org>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 16:00:08 +0900
Message-ID: <48F44378.6070109@kernel.org>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>	<48F3D8E2.8000006@kernel.org>	<20081014070728.386a9cf2@mjolnir.drzeus.cx>	<48F43025.8050705@kernel.org>	<20081014080304.65445c51@mjolnir.drzeus.cx>	<48F43844.9080603@kernel.org> <20081014085933.67b602ae@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43373 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbYJNHC6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 03:02:58 -0400
In-Reply-To: <20081014085933.67b602ae@mjolnir.drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Pierre Ossman wrote:
> On Tue, 14 Oct 2008 15:12:20 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
>> Pierre Ossman wrote:
>>> Do you remember if that's a new chip designation, or 3132 (rev 02)?
>>> Just so I know what to keep an eye out for.
>> Yeah, it had a new designation.  Something like 3132-2 (don't confuse it
>> with 3132 2 ports or 3132 2 ports SATA 2, yeah a lot of 2s there).
>>
> 
> Ok. Thanks for all the info. :)
> 
> Any objections to putting this on the wiki, so the next person having
> less than expected performance doesn't have to ask on the mailing list?

Hmmm... Let me check this with SIMG first so that I have more concrete
idea about which ones have what kind of limit and whether there are any
which don't have such limitations.

Thanks.

-- 
tejun
