From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 02:48:08 -0400
Message-ID: <4A6807A8.30403@pobox.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33267 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbZGWGsL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 02:48:11 -0400
In-Reply-To: <4A67FF56.5040708@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> AA was added in SATA II, and the SATA II specs specifically mention that
>> AA was not present in SATA 1.0.
> 
> Yeap, it wasn't in SATA 1.0 but it was in ahci 1.0 so _theoretically_
> all ahcis should be fine with it.  We can introduce ATA_FLAG_FPDMA_AA
> and let the drivers set it.


Yep -- that was the logical conclusion of my rhetorical question at the 
beginning of this thread ;-)

	Jeff


