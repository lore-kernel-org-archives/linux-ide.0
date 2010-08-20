From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: Intel IDE-R support
Date: Fri, 20 Aug 2010 15:13:43 -0400
Message-ID: <4C6ED3E7.3010804@garzik.org>
References: <20100820173327.30661.51410.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53347 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0HTTNr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Aug 2010 15:13:47 -0400
Received: by vws3 with SMTP id 3so3426947vws.19
        for <linux-ide@vger.kernel.org>; Fri, 20 Aug 2010 12:13:47 -0700 (PDT)
In-Reply-To: <20100820173327.30661.51410.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 08/20/2010 01:33 PM, Alan Cox wrote:
> Intel IDE-R devices are part of the Intel AMT management setup. They don't
> have any special configuration registers or settings so the ata_generic
> driver will support them fully.
>
> Rather than add a huge table of IDs for each chipset and keep sending in
> new ones this patch autodetects them.
>
> [Added some further comments]
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> Acked-by: Tejun Heo<tj@kernel.org>

One last question:  is this extremely urgent?

As the merge window is closed, I would prefer to have this in #upstream 
(linux-next, ie. 2.6.37) rather than #upstream-fixes (2.6.36-rc).

	Jeff




