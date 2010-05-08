From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Sat, 08 May 2010 10:40:35 +0200
Message-ID: <4BE52383.9080908@kernel.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org> <4BE31D57.6020400@garzik.org> <4BE3A1A6.1040106@kernel.org> <4BE48742.8060604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37532 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab0EHIkt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 May 2010 04:40:49 -0400
In-Reply-To: <4BE48742.8060604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 05/07/2010 11:33 PM, Jeff Garzik wrote:
> I'm not sure the usefulness is limited, as it definitely avoids power
> spikes on server BIOSen that care.

So, are there actually machines which get affected by this?  In that
case, sure, the current behavior is the right one.

> Also, it seems unwise for the Linux SATA driver to do the exact
> -opposite- of what the SSS bit intends, by default.

Yeah, well, the thing is that SSS in itself doesn't really indicate
need for staggered spin up.  It just says it knows how to.

Thanks.

-- 
tejun
