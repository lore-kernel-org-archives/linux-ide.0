From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Wed, 22 Jul 2009 23:59:11 -0400
Message-ID: <4A67E00F.40808@pobox.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46960 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072AbZGWD7P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 23:59:15 -0400
In-Reply-To: <1248320734.9035.22.camel@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, tj@kernel.org

Shaohua Li wrote:
> hi,
> The SATA spec defines DMA setup FIS auto-activate optimization for FPDMA
> transfers. I had an attempt to add it, though my test doesn't show obvious
> performance improvement (not worse too), I wonder why not add this feature?
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

I agree, we should turn it on -- but doesn't this also have a controller 
dependency?

IIRC, not all NCQ-capable controllers support this feature...  SATA 1.0 
hardware may not behave properly in response, no?

	Jeff


