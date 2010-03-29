From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] ahci: clean up board IDs
Date: Mon, 29 Mar 2010 16:20:08 -0400
Message-ID: <4BB10B78.9070409@garzik.org>
References: <4BB00337.1030302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47910 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0C2UUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 16:20:10 -0400
Received: by pwi5 with SMTP id 5so6985059pwi.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 13:20:10 -0700 (PDT)
In-Reply-To: <4BB00337.1030302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 03/28/2010 09:32 PM, Tejun Heo wrote:
> ahci over time has grown a number of board IDs and it's a bit of mess
> right now.  Clean it up such that,
>
> * board_id_* now live in a separate enum board_ids and numbers are
>    assigned automatically.
>
> * Board IDs assigned to features are separated from the ones assigned
>    to specific implementations and both are ordered alphabetically.
>
> * For NV MCPs, define per-generation alias board_ids and assign
>    matching aliases in the pci id table.  This makes mcp_linux, 67-73
>    use board_ahci_mcp65 instead of board_ahci_yesncq.  Both are
>    identical in content.
>
> * Kill now unused board_ahci_nopmp and board_ahci_yesncq.
>
> This patch doesn't cause any functional change but will make future
> changes to board_ids and quirks much less painful.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Peer Chen<pchen@nvidia.com>
> ---
> Updated against the new #upstream.  Thanks.
>
>   drivers/ata/ahci.c |  237 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 117 insertions(+), 120 deletions(-)

applied


