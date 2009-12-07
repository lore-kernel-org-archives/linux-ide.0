From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH resend] pata_hpt3x2n: fix clock turnaround
Date: Mon, 07 Dec 2009 14:29:26 -0500
Message-ID: <4B1D5796.5080306@pobox.com>
References: <200912071652.57615.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47688 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772AbZLGT3W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:29:22 -0500
Received: by yxe17 with SMTP id 17so4209267yxe.33
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2009 11:29:28 -0800 (PST)
In-Reply-To: <200912071652.57615.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 12/07/2009 08:52 AM, Sergei Shtylyov wrote:
> The clock turnaround code still doesn't work for several reasons:
>
> - 'USE_DPLL' flag in 'ap->host->private_data' is never initialized or updated,
>    so the driver can only set the chip to the DPLL clock mode, not the PCI mode;
>
> - the driver doesn't serialize access to the channels depending on the current
>    clock mode like the vendor drivers, so the clock turnaround is only executed
>    "optionally", not always as it should be;
>
> - the wrong ports are written to when hpt3x2n_set_clock() is called for the
>    secondary channel;
>
> - hpt3x2n_set_clock() can inadvertently enable the disabled channels when
>    resetting the channel state machines.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> Cc: stable@kernel.org
>
> ---
> Resending with the corrected subject...
>
> The patch is against the recent Linus' tree. It's intended to go into all
> stable kernels starting with 2.6.19, when the PATA drivers were first merged --
> the version change hunks could be dropped when merging to the older kernels...
>
>   drivers/ata/pata_hpt3x2n.c |   64 ++++++++++++++++++++++++---------------------
>   1 files changed, 35 insertions(+), 29 deletions(-)

FWIW, I am basically waiting on Linus's pull before opening 
#upstream-fixes (2.6.33) and #upstream (2.5.34) branches of libata-dev.git.

As soon as the merge happens, I'll immediately apply the patches from 
you and others...

	Jeff





