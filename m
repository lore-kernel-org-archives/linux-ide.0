From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 14 May 2008 10:53:46 -0400
Message-ID: <482AFCFA.40708@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com> <482AFB12.3040005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2712 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356AbYENOxr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 10:53:47 -0400
In-Reply-To: <482AFB12.3040005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
>..
> At the moment, I have the Sil PM plugged in, and it all behaves nicely.
> The previous failure was with the Marvell PM, so I'll hook that up next
> and retest with it.
..

It went bonkers again.  This is with 2.6.25.
I'll build 2.6.26-git and try again with that shortly.

One thing about sata_sil24 --> it *really* doesn't like to handle
hotplug events while in the midst of EH.

I unplugged the host cable from the PM, and the EH just kept on
going and going.

I then unplugged the sata_sil24 PCIe host adapter card,
and it still took quite some time to give up on the Energizer Bunny routine.  :)

Anyway, this is my main machine, so I'll be out for a spell now while
rebuilding/rebooting.

Cheers
