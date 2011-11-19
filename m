From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Mysterious MWDMA timings (Was: PATCH: Add CFA modes)
Date: Sat, 19 Nov 2011 20:38:42 +0400
Message-ID: <4EC7DB92.2020801@mvista.com>
References: <1155232332.24077.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47274 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1KSQjj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Nov 2011 11:39:39 -0500
Received: by bke11 with SMTP id 11so4683725bke.19
        for <linux-ide@vger.kernel.org>; Sat, 19 Nov 2011 08:39:37 -0800 (PST)
In-Reply-To: <1155232332.24077.7.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, vojtech@suse.cz
Cc: linux-ide@vger.kernel.org

Hello.

On 10-08-2006 21:52, Alan Cox wrote:

>> From nobody Mon Sep 17 00:00:00 2001
> From: root<root@hraefn.swansea.linux.org.uk>
> Date: Thu Aug 10 18:06:38 2006 +0100
> Subject: [PATCH] Add compact flash support

> The CFA world has some additional rules and drive modes we need to support for
> newer expansion cards and on embedded boxes

    Sorry, this is very old patch, but the issue I'm going to touch is even 
much older...

> @@ -1913,6 +1945,8 @@ static const struct ata_timing ata_timin
>   	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
>   	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
>
> +	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
> +	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },

    Alan, I keep wondering where you got these 25 ns setup timings and where 
such numbers for MWDMA modes 0-2 came from (that should rahter be a question 
for Vojtech Pavlik, the author of drivers/ide/ide-timigs.c from which this 
code was apparently copied; I'm including him in the CC in hopes he could 
remember why these numbers occured, though it's about 10 years since that code 
was written) -- they're not in any spec. Actually, according to the comments 
to 'struct ata_timings', its 'setup' field corresponds to address valid to 
DIOR-/DIOW- setup timing (t1) which only makes sense for the PIO modes, so why 
it's not zero for MWDMA modes is beyond me also...
    What I'd like to do is use this field for MWDMA as the CS(1:0) valid to 
DIOR-/DIOW- timing (tM) which seems to correspond to t1 quite closely (and the 
numbers for tM are slightly less than those used on MWDMA modes now) -- the 
controller I'm writing the driver for now has tM timing programmable...
Or should I just a new timing to 'struct ata_timing'? Or should I just keep 
the tM timing table private to the driver as it's the only user of this 
timing? Opinions?

MBR, Sergei
