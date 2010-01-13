From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Thu, 14 Jan 2010 06:58:12 +1100
Message-ID: <1263412692.724.222.camel@pasglop>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>
	 <1263186759.724.132.camel@pasglop>
	 <19277.51029.197524.477689@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59789 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab0AMUA6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jan 2010 15:00:58 -0500
In-Reply-To: <19277.51029.197524.477689@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On Wed, 2010-01-13 at 14:15 +0100, Mikael Pettersson wrote:
> Seems to me the "irq 30: nobody cared" and "Disabling IRQ #30"
> are the real problems. Is the pata_macio irq handler registered
> too late, or does it ignore the interrupt?

It's getting an interrupt it doesn't expect around the reset. The
ata freeze code actually tries to prevent that with a read of
the status register but that doesn't appear to work. I think it's
a bug in the drive FW but I'm not sure of the details.

I'll try to make up a workaround involving masking the interrupt
until the first taskfile completes. I'll send you a patch to test
when I find time to write it.

Cheers
Ben.

