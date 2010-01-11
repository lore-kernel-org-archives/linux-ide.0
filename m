From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Mon, 11 Jan 2010 16:01:49 +0900
Message-ID: <4B4ACCDD.8040803@kernel.org>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se> <1263186759.724.132.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35902 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab0AKG4L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 01:56:11 -0500
In-Reply-To: <1263186759.724.132.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hello,

On 01/11/2010 02:12 PM, Benjamin Herrenschmidt wrote:
> Tejun, what's your take here ? It looks like reading the status reg
> is not enough to bring the interrupt down. We could try to disable_irq
> in freeze() (we know we don't share interrupts in the case of macio)
> and re-enable it right after firing off the first taskfile maybe ?

It would be best if the controller has an IRQ pending bit and IRQ can
be cleared as spurious on those bogus interrupts.  The reason why SFF
IDE interface is so prone to IRQ storm is because there's no way the
driver can tell whether the controller is raising interrupt or not.
Does the controller have a way to clear IRQ other than reading the
status reg?

Thanks.

-- 
tejun
