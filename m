From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Wed, 26 Nov 2008 11:45:32 +0900
Message-ID: <492CB84C.8090706@kernel.org>
References: <49263552.8090602@kernel.org>	<492C30FC.2090200@garzik.org> <20081125171559.222e499f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35161 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYKZCpu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 21:45:50 -0500
In-Reply-To: <20081125171559.222e499f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Tue, 25 Nov 2008 12:08:12 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Tejun Heo wrote:
>>> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
>>> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
>>> clear them.  This protects ata_piix against nobody-cared which gets
>>> reported not so rarely.
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> ---
>>>  drivers/ata/ata_piix.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 53 insertions(+), 1 deletion(-)
>> It's tough to call this #upstream-fixes material, unfortunately...  For 
>> this late into -rc, I am very nervous about changing the ATA interrupt 
>> path for millions of machines.
> 
> I would like to go through the PIIX errata first. There are some rules
> about what registers may not be touched during a transfer on some of the
> devices and breaking them is *bad*. I don't think this is a problem but
> it makes me nervous.

Well, the BMDMA status register read and cleared iff no qc is in
flight so the patch isn't likely to break any of that.  That said,
it's true that this is a big change this late in the release cycle.  I
have no problem with postponing it to the next -rc1.  Also, this patch
is already in openSUSE11.1 and SLES11 betas, so we'll know a lot more
about how this works in the coming weeks.  :-)

Thanks.

-- 
tejun
