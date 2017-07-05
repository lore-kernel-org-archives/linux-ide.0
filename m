From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ata: ahci_platform: Handle shutdown with
 ata_platform_shutdown_one()
Date: Wed, 5 Jul 2017 10:51:14 -0400
Message-ID: <20170705145114.GC19330@htj.duckdns.org>
References: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
 <1499104962-17498-2-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36372 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdGEOvT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2017 10:51:19 -0400
Content-Disposition: inline
In-Reply-To: <1499104962-17498-2-git-send-email-nwatters@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 03, 2017 at 02:02:42PM -0400, Nate Watterson wrote:
> To avoid interfering with a new kernel started using kexec, quiesce
> host controller DMA interrupts during driver shutdown with
> ata_platform_remove_one().
> 
> Change-Id: Iedee7f7ba12172b3d34796a3e3b92dbb72d4ed9c
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>

Please drop the Change-Id when posting upstream.  Also, it probably
would be better to roll this into the previous patch.

Thanks.

-- 
tejun
