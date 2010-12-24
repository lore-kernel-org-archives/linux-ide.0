From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: issue DIPM enable commands with
 LPM state updated
Date: Fri, 24 Dec 2010 13:38:54 -0500
Message-ID: <4D14E8BE.90405@garzik.org>
References: <4D00F20B.2080908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60654 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0LXSi6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:38:58 -0500
Received: by qyk12 with SMTP id 12so8055180qyk.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 10:38:57 -0800 (PST)
In-Reply-To: <4D00F20B.2080908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kyle McMartin <kyle@mcmartin.ca>, stable <stable@kernel.org>

On 12/09/2010 10:13 AM, Tejun Heo wrote:
> Low level drivers may behave differently depending on the current
> link->lpm_policy.  During ata_eh_set_lpm(), DIPM enable commands are
> issued after the successful completion of ap->ops->set_lpm(), which
> means that the controller is already in the target state.  This causes
> DIPM enable commands to be processed with mismatching controller power
> state and link->lpm_policy value.
>
> In ahci, link->lpm_policy is used to ignore certain PHY events if LPM
> is enabled; however, as DIPM commands are issued with stale
> link->lpm_policy, they sometimes end up triggering these conditions
> and get aborted leading to LPM configuration failure.
>
> Fix it by updating link->lpm_policy before issuing DIPM enable
> commands.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Kyle McMartin<kyle@mcmartin.ca>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-eh.c |   17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

applied


