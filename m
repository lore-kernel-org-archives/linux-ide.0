From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 15:12:38 +0900
Message-ID: <4A67FF56.5040708@kernel.org>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50440 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbZGWGMw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 02:12:52 -0400
In-Reply-To: <4A67FE1A.1050408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> IIRC, AA is in the ahci spec from rev 1.0, so if controllers implement
> 
> AHCI?  Perhaps.   But AA is not in the _Serial ATA_ 1.0 spec...
> 
> It was added in SATA II, and the SATA II specs specifically mention that
> AA was not present in SATA 1.0.

Yeap, it wasn't in SATA 1.0 but it was in ahci 1.0 so _theoretically_
all ahcis should be fine with it.  We can introduce ATA_FLAG_FPDMA_AA
and let the drivers set it.  It would probably be better to set it
during -rc's and then disable it for release for a few devel cycles.

Thanks.

-- 
tejun
