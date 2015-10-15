From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: qoriq: Fix a compiling warning
Date: Thu, 15 Oct 2015 17:35:20 +0200
Message-ID: <15555694.OtW6JZzsoS@wuerfel>
References: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com> <20151015151152.GB27717@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54401 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbJOPgB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Oct 2015 11:36:01 -0400
In-Reply-To: <20151015151152.GB27717@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, Tang Yuantian <Yuantian.Tang@freescale.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, fengguang.wu@intel.com

On Thursday 15 October 2015 11:11:52 Tejun Heo wrote:
> 
> On Wed, Oct 14, 2015 at 04:46:52PM +0800, Tang Yuantian wrote:
> > kbuild test robot reports the warnings:
> > drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> > >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> > >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> > 
> > This patch fixed it by introducing a local variable.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hmmm... why is the patch signed off by Arnd?  You can't sign off for
> other people.  If this was suggested by Arnd, please use
> "Suggested-by:" or "Original-patch-by:".

The original patch I sent had my Signed-off-by, see
https://lkml.org/lkml/2015/9/14/64

Tang Yuantian now submitted it properly with a full changelog text
but forgot to add the 'From: Arnd Bergmann <arnd@arndb.de>' line at
the start and the second Signed-off-by below mine.

	Arnd
