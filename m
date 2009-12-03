From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_hpt{37x|3x2n}: fix timing register masks (take 2)
Date: Thu, 03 Dec 2009 02:36:23 -0500
Message-ID: <4B176A77.3080606@pobox.com>
References: <200911272129.02616.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:46659 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZLCHgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:36:18 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so995273gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:36:25 -0800 (PST)
In-Reply-To: <200911272129.02616.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

On 11/27/2009 01:29 PM, Sergei Shtylyov wrote:
> These drivers inherited from the older 'hpt366' IDE driver the buggy timing
> register masks in their set_piomode() metods. As a result, too low command
> cycle active time is programmed for slow PIO modes.  Quite fortunately, it's
> later "fixed up" by the set_dmamode() methods which also "helpfully" reprogram
> the command timings, usually to PIO mode 4; unfortunately, setting an UltraDMA
> mode #N also reprograms already set PIO data timings, usually to MWDMA mode #
> max(N, 2) timings...
>
> However, the drivers added some breakage of their own too:  the bit that they
> set/clear to control the FIFO is sometimes wrong -- it's actually the MSB of
> the command cycle setup time; also, setting it in DMA mode is wrong as this
> bit is only for PIO actually and clearing it for PIO modes is not needed as
> no mode in any timing table has it set...
>
> Fix all this, inverting the masks while at it, like in the 'hpt366' and
> 'pata_hpt366' drivers; bump the drivers' versions, accounting for recent
> patches that forgot to do it...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> Cc: stable@kernel.org
>
> ---
> The patch is against the recent Linus' tree. It's intended to go into all
> stable kernels starting with 2.6.19, when the PATA drivers were first merged --
> the version change hunks should be dropped when merging to the older kernels...
>
>   drivers/ata/pata_hpt37x.c  |   32 +++++++++++++++-----------------
>   drivers/ata/pata_hpt3x2n.c |   17 ++++++++---------
>   2 files changed, 23 insertions(+), 26 deletions(-)

applied


