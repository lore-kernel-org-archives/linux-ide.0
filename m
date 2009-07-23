From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 12:50:37 +0900
Message-ID: <4A67DE0D.5040101@kernel.org>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47333 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbZGWDvJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 23:51:09 -0400
In-Reply-To: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Shaohua Li wrote:
> hi,
> The SATA spec defines DMA setup FIS auto-activate optimization for FPDMA
> transfers. I had an attempt to add it, though my test doesn't show obvious
> performance improvement (not worse too), I wonder why not add this feature?
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Eh... It's not clear whether all controllers support AA and it's also
not clear whether devices which claim to support AA actually work
properly when AA is enabled.  For optional features in ATA(PI), the
best we can do is probably to allow enabling it from userland or bios.
It used to be better for ATA compared to ATAPI but with the
introduction of SSDs, the situation has gotten worse rapidly.  :-(

Thanks.

-- 
tejun
