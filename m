From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci_platform: Add shutdown handler
Date: Fri, 4 Aug 2017 13:35:22 -0700
Message-ID: <20170804203522.GA4050379@devbig577.frc2.facebook.com>
References: <1500578784-15407-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33819 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdHDUf0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Aug 2017 16:35:26 -0400
Content-Disposition: inline
In-Reply-To: <1500578784-15407-1-git-send-email-nwatters@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 20, 2017 at 03:26:24PM -0400, Nate Watterson wrote:
> The newly introduced ahci_platform_shutdown() method is called during
> system shutdown to disable host controller DMA and interrupts in order
> to avoid potentially corrupting or otherwise interfering with a new
> kernel being started with kexec.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
