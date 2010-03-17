From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 2/3] ahci: clean up board IDs
Date: Wed, 17 Mar 2010 13:44:56 -0400
Message-ID: <4BA11518.30500@garzik.org>
References: <4B98575C.5050508@kernel.org> <4B9857EA.5090101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f198.google.com ([209.85.216.198]:51386 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0CQRpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 13:45:04 -0400
Received: by pxi36 with SMTP id 36so794685pxi.21
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2010 10:45:02 -0700 (PDT)
In-Reply-To: <4B9857EA.5090101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

On 03/10/2010 09:39 PM, Tejun Heo wrote:
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
> This might seem a bit too much for #upstream-fixes but it contains no
> functional changes and will ease future fixes, so I think including it
> in -fixes would be better.

It actually makes merging a lot more difficult, considering that libahci 
-- which includes large amounts of ahci code movement -- was committed 
to #upstream a week before this patch was posted.

Because of libahci changes, I think patch #2 (this patch) and patch #3 
are more appropriate for #upstream.

The "(pdev->vendor != PCI_VENDOR_ID_NVIDIA)" may be overly broad, but 
it's not wrong for 2.6.34, IMO.

	Jeff



