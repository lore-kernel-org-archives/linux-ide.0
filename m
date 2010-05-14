From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: use ata_pci_sff_activate_host()
 instead of ata_host_activate()
Date: Sat, 15 May 2010 00:05:48 +0200
Message-ID: <4BEDC93C.80108@kernel.org>
References: <4BED1C82.10102@kernel.org> <4BEDBCC1.5080700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48806 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243Ab0ENWF6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2010 18:05:58 -0400
In-Reply-To: <4BEDBCC1.5080700@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Robert Hancock <hancockrwd@gmail.com>

Hello,

On 05/14/2010 11:12 PM, Jeff Garzik wrote:
> hmmmm.  I agree 100% with this patch, but is it a recent regression?

It's more than a year old at least.  It's a bit surprising that no one
reported this before.

> At -rc7, we are trying hard to only include fixes for regressions.
> 
> Around -rc1, I would stuff this into #upstream-fixes without hesitation.
> But now, I'm thinking #upstream.

Yeap, sure.  We can wait some time after it makes -rc1 and then push
it through -stable.

Thanks.

-- 
tejun
