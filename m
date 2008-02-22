From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 09:32:14 +0000
Message-ID: <20080222093214.00ab5c58@core>
References: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54245 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762452AbYBVJmF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 04:42:05 -0500
In-Reply-To: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, "Su, Henry" <Henry.Su@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

On Fri, 22 Feb 2008 12:55:20 +0800
"Huang, Shane" <Shane.Huang@amd.com> wrote:

> Jeff:
> 
> SB700 SATA controller can support 64 bit DMA, the previous commit
> badc2341579511a247f5993865aa68379e283c5c was added with
> careless reference to SB600, which should be modified by this patch.

Does the SB700 have the same limits as the SB600 on 256 sectors in one
PRD entry ? If it does then this change needs to wait until the
workaround for that is included.
