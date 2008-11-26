From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Wed, 26 Nov 2008 09:12:53 +0100
Message-ID: <492D0505.2030704@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se> <49263F80.2060607@kernel.org> <492BF6FB.1050004@how.dk> <492CB89F.4010108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:41254 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYKZIM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Nov 2008 03:12:59 -0500
In-Reply-To: <492CB89F.4010108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Peter Favrholdt wrote:
>> Hi Tejun,
>>
>> After running dd several times finally my setup failed. Unfortunately it
>> didn't recover :-(
> 
> Eh... crap.
> 
>> Tejun Heo wrote:
>>> sata_promise hardreset doesn't seem to be able to acquire the initial
>>> D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
>>> follow-up SRST.
>>>
>>>  http://article.gmane.org/gmane.linux.ide/36186
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> ---
>>> Peter, can you please test this one too?  It's essentially the same
>>> code just slightly prettier.  Mikael, what do you think about this?
> 
> Does unloading and reloading the driver make the device recognized
> again?

Yes I tried modprobe -r sata_promise and modprobe sata_promise: It 
didn't recognize the device. I forgot to post the dmesg output, sorry.

Best regards,

Peter
