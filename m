From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 02:07:22 -0400
Message-ID: <4A67FE1A.1050408@pobox.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36544 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbZGWGH2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 02:07:28 -0400
In-Reply-To: <4A67F8ED.2070204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> IIRC, AA is in the ahci spec from rev 1.0, so if controllers implement

AHCI?  Perhaps.   But AA is not in the _Serial ATA_ 1.0 spec...

It was added in SATA II, and the SATA II specs specifically mention that 
AA was not present in SATA 1.0.

	Jeff


