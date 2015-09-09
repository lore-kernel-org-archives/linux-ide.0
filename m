From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Wed, 9 Sep 2015 10:01:30 -0400
Message-ID: <20150909140130.GB22909@mtj.duckdns.org>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:32806 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbIIOBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2015 10:01:35 -0400
Content-Disposition: inline
In-Reply-To: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 09, 2015 at 05:16:22PM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> >> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> 
> This patch fixed it by assigning 0 to px_is and px_cmd variables.
> This patch also remove line 'struct ccsr_ahci *reg_base' which is
> not referred by any other codes and thus a dead one.

Hmm... I think the problem here is that the complier can't know
whether qoriq_priv->type would change across intervening function
calls.  Maybe a better solution is caching the type in a local
variable so that the compiler can tell that those two tests will
always move together?  It generally isn't a good idea to clear
variables unnecessarily as that can hide actual bugs that compiler can
detect.

Thanks.

-- 
tejun
