From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Wed, 26 Nov 2008 11:46:55 +0900
Message-ID: <492CB89F.4010108@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se> <49263F80.2060607@kernel.org> <492BF6FB.1050004@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35181 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYKZCrM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 21:47:12 -0500
In-Reply-To: <492BF6FB.1050004@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Peter Favrholdt wrote:
> Hi Tejun,
> 
> After running dd several times finally my setup failed. Unfortunately it
> didn't recover :-(

Eh... crap.

> Tejun Heo wrote:
>> sata_promise hardreset doesn't seem to be able to acquire the initial
>> D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
>> follow-up SRST.
>>
>>  http://article.gmane.org/gmane.linux.ide/36186
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> ---
>> Peter, can you please test this one too?  It's essentially the same
>> code just slightly prettier.  Mikael, what do you think about this?

Does unloading and reloading the driver make the device recognized
again?

Thanks.

-- 
tejun
