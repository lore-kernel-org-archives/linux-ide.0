From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH resend] pata_hpt{37x|3x2n}: SATA mode filtering
Date: Fri, 07 Jan 2011 22:34:08 -0500
Message-ID: <4D27DB30.6080201@pobox.com>
References: <201012252244.02021.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab1AHDeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 22:34:15 -0500
Received: by vws16 with SMTP id 16so7391603vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 19:34:14 -0800 (PST)
In-Reply-To: <201012252244.02021.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/25/2010 02:44 PM, Sergei Shtylyov wrote:
> The Marvell bridge chips used on HighPoint SATA cards do not seem to support
> the UltraDMA modes 1, 2, and 3 as well as any MWDMA modes;  these cards are
> based on HPT372/372A/372N/374 chips (judging from the vendor drivers), so
> the Linux drivers need to have a mode_filter() method for these chips...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> --
> The patch is against the recent Linus' tree.
> Resending with the corrected subject...
>
>   drivers/ata/pata_hpt37x.c  |   54 ++++++++++++++++++++++++++++++++-------
>   drivers/ata/pata_hpt3x2n.c |   61 ++++++++++++++++++++++++++++++++++++---------
>   2 files changed, 93 insertions(+), 22 deletions(-)

applied


