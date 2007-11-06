From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned
 long
Date: Tue, 6 Nov 2007 10:51:51 +0000
Message-ID: <20071106105151.2e3d15b8@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<11943275501285-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50962 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755528AbXKFKvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:51:17 -0500
In-Reply-To: <11943275501285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue,  6 Nov 2007 14:39:03 +0900
Tejun Heo <htejun@gmail.com> wrote:

> xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
> take and return unsigned int.
> 
> While at it, rename @adev of ata_pci_default_filter() to @dev for
> consistency.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

The filter type was purposefully unsigned long to allow for expansion (eg
for SWDMA) without breaking drivers. No problem with it changing but I'd
say "unsigned int" was the worst possible choice - its now shorter (no
room for expansion) and size dependant on arch. u32 would be shorter and
consistent across all platforms, ulong would have more room for expansion.

Alan
