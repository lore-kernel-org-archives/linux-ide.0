From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC]: recovery from power-up-in-standby feature
Date: Sun, 04 Mar 2007 18:37:09 -0500
Message-ID: <45EB5825.501@garzik.org>
References: <45EB2F6D.7050407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38998 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbXCDXhQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 18:37:16 -0500
In-Reply-To: <45EB2F6D.7050407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> ATA/SATA drives can be set to not spinup automatically at power-on,
> for use in staggered spin-up applications where frying power supplies
> is to be avoided.
> 
> These drives may return incomplete IDENTIFY responses
> until they have been spun-up first by the device driver.
> 
> There are two ways this happens, and the drive lets us know
> which it expects based on the initial, partial IDENTIFY response.
> 
> (1) The old method (34GB WD Raptor drives) will spin up on receipt of
> any media-access command.  The trick here being, we that don't have
> full IDENTIFY info to properly issue just *any* media command,
> so this has to be controlled carefully.
> 
> (2) The more common method is for the drive to require an explicit
> set-features "spin-up" subcommand after the IDENTIFY.
> 
> The patch below implements the latter method (tested, works for me).

I think we would want to test bit 6 of IDENTIFY DEVICE word 83, issue 
SET FEATURES - SPIN UP command if set, otherwise do a READ VERIFY or 
some other media access command.


> But as you can see, there is an "#if 0 FIXME" section around
> the code which attempts to deal with the "spin up on any media access"
> variant of this protocol.  That code just doesn't work for me,
> and I'm hoping Jeff/Tejun might be able to point out where it's gone silly.
> +#if 0
> +    /*
> +     * FIXME: this always fails with AC_ERR_DEV,
> +     * even when issued on a spun-up drive
> +     * (accomplished by commenting out the if-stmt below).
> +     *
> +     * What's wrong here???
> +     */
> +    if (!tried_spinup && id[2] == 0x8c73)
> +    {
> +        tried_spinup = 1;
> +        /*
> +         * Drive powered up in standby mode, and returned only
> +         * partial IDENTIFY data.  This requires a media access
> +         * command (to force a spin-up) before the drive can
> +         * return a complete set of IDENTIFY data.
> +         * Here, we use READ_VERIFY(LBA=0) to force the spin-up.
> +         */

ata_exec_internal() passes ATA_QCFLAG_RESULT_TF to the queued cmd.  So, 
what values are returned by the device in the taskfile registers?

AC_ERR_DEV means the command made it all the way to the device, which 
then spit back the command with ERR=1 in the Status shadow register.

	Jeff


