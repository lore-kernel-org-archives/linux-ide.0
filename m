From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 12:47:20 -0400
Message-ID: <4634CC18.4080208@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4658 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957AbXD2QrX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 12:47:23 -0400
In-Reply-To: <4634CAEC.4010700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> So, this is specific to SATA (the host side at least) piix && PIO READ,
> right?  I think we can fit this code nicely into
> piix_sata_error_handler() if we make sure that it triggers under the
> right condition - after a PIO READ command fails due to HSM violation
> caused by stuck DRQ.

Yeah, so far it's just PIO FROM DEVICE on a "SATA" device on ata_piix.
It *may* be more widespread than that, but we'll have to test some others.

> Can you please perform similar test on a native PATA device connected to
> native PATA controller?  I'm curious whether SRST makes real silicons
> forget about the on-going command.

I'll dig through some other hardware here and see what I have.
This'll take a few hours.

Cheers

