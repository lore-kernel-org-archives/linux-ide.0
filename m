From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Fri, 28 Nov 2008 11:31:31 +0900
Message-ID: <492F5803.2080302@kernel.org>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org>	<20081126104731.4b370d18@lxorguk.ukuu.org.uk>	<492D88B9.7040608@garzik.org>	<492D8B1C.405@kernel.org> <20081126184024.3447c017@lxorguk.ukuu.org.uk> <492D9C30.8080208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44360 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbYK1Cbt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2008 21:31:49 -0500
In-Reply-To: <492D9C30.8080208@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Alan Cox wrote:
>>> circumstances, during resume SRST, the drive would raise the IRQ line
>>> regardless of NIEN and will stay that way for several seconds, thus
>>> triggering nobody cared.  Other than detecting and clearing the
>>> spurious IRQ, there just isn't much driver can do to work around
>>> problems like this.
>> There is. It also means your patch isn't sufficient - if that IRQ had
>> been level triggered you'd have hung the box solid.
> 
> Right, the attached patch fixed it so it must have been the controller
> latching the IRQ.
> 
>> The old IDE code makes use of disable_irq/enable_irq (and really ought to
>> make use of on chip private IRQ mask bits as first choice but doesn't).
>>
>> Sounds to me like there are two things we can do to help
>>
>> Make the nIEN masking via a helper that can on suitable chips also mask
>> on chip.
>>
>> Make use of disable_irq_nosync() in the case of devices that ignore nIEN
>> in the IRQ handler, setting a flag then re-enable it when the driver
>> path completes the reset and the bit goes clear.
>>
>> We need to start using enable/disable_irq and/or local chip IRQ masking
>> for PIO in some places anyway.
> 
> Agreed.  I think we should use disable/enable_irq for all controller
> which don't have proper IRQ masking mechanism (NIEN doesn't count) for
> both reliability and so that we move PIO out of irq handler.  Jeff,
> this has come up quite a few times now, what do you think?

OSDL bz#10884 seems to suffer similar problem.  The patch fixes it.

  http://bugzilla.kernel.org/show_bug.cgi?id=10884

We definitely need to do something about it.

-- 
tejun
