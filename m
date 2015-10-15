From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: Fix a compiling warning
Date: Thu, 15 Oct 2015 11:11:52 -0400
Message-ID: <20151015151152.GB27717@mtj.duckdns.org>
References: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34496 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbJOPLz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Oct 2015 11:11:55 -0400
Content-Disposition: inline
In-Reply-To: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Cc: hdegoede@redhat.com, fengguang.wu@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Hello,

On Wed, Oct 14, 2015 at 04:46:52PM +0800, Tang Yuantian wrote:
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> 
> This patch fixed it by introducing a local variable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmmm... why is the patch signed off by Arnd?  You can't sign off for
other people.  If this was suggested by Arnd, please use
"Suggested-by:" or "Original-patch-by:".

Thanks.

-- 
tejun
