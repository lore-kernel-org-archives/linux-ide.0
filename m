From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: don't diddle with nIEN on mcp55
Date: Wed, 02 Jun 2010 13:51:14 -0400
Message-ID: <4C069A12.4090602@garzik.org>
References: <4C052751.3070403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab0FBRvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 13:51:18 -0400
Received: by gye5 with SMTP id 5so2370199gye.19
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2010 10:51:16 -0700 (PDT)
In-Reply-To: <4C052751.3070403@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Cengiz_G=FCnay?= <cgunay@emory.edu>, stable@kernel.org

On 06/01/2010 11:29 AM, Tejun Heo wrote:
> On mcp55, nIEN gets stuck once set and liteon blueray rom iHOS104-08
> violates ATA specification and fails to set I on D2H Reg FIS if nIEN
> is set when the command was issued.  When the other party is followin=
g
> the spec, both devices can work fine but when the two flaws are put
> together, they can't talk to each other.
>
> mcp55 has its own IRQ masking mechanism and there's no reason to mess
> with nIEN in the first place.  Fix it by dropping nIEN diddling from
> nv_mcp55_freeze/thaw().
>
> This was originally reported by Cengiz.  Although Cengiz hasn't
> verified the fix yet, I could reproduce this problem and verfiy the
> fix.  Even if Cengiz is experiencing different or additional problems=
,
> this patch is needed.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Cengiz G=FCnay<cgunay@emory.edu>
> Cc: stable@kernel.org
> ---
>   drivers/ata/sata_nv.c |    2 --

applied


