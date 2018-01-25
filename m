From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_it821x: Replace mdelay with usleep_range in
 it821x_firmware_command
Date: Thu, 25 Jan 2018 07:31:15 -0800
Message-ID: <20180125153115.GF17457@devbig577.frc2.facebook.com>
References: <1516876379-12834-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36915 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeAYPbT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2018 10:31:19 -0500
Content-Disposition: inline
In-Reply-To: <1516876379-12834-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 06:32:59PM +0800, Jia-Ju Bai wrote:
> After checking all possible call chains to it821x_firmware_command here,
> my tool finds that it821x_firmware_command 
> is never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> And it821x_firmware_command calls kmalloc(GFP_KERNEL), 
> so it proves again that it821x_firmware_command 
> can call functions which can sleep.
> Thus mdelay can be replaced with usleep_range to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied to libata/for-4.16.

Thanks.

-- 
tejun
