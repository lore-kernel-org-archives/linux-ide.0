From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 14:45:17 +0900
Message-ID: <4A67F8ED.2070204@kernel.org>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32945 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbZGWFp1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 01:45:27 -0400
In-Reply-To: <20090723054007.GA7473@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

Shaohua Li wrote:
>> IIRC, not all NCQ-capable controllers support this feature...  SATA 1.0 
>> hardware may not behave properly in response, no?
> It appears the AHCI spec doesn't define a HBA capability about this
> feature, but I'm likely wrong as I'm not quite familar with SATA.

IIRC, AA is in the ahci spec from rev 1.0, so if controllers implement
the spec correctly, it should work.  But even for ahcis, if we enable
it by default, I'm fairly sure we'll be met by a number of unpleasant
surprises.  Not sure whether doing that would be worth the trouble or
not.

Thanks.

-- 
tejun
