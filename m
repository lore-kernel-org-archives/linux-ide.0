From: Tejun Heo <tj@kernel.org>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 08 Apr 2009 14:31:47 -0700
Message-ID: <49DD17C3.7040607@kernel.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	 <1239156559.10104.7.camel@localhost> <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com> <49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com> <49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53265 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765209AbZDHVcr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 17:32:47 -0400
In-Reply-To: <49DD1465.6070001@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: michael@ellerman.id.au, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>

Timur Tabi wrote:
> Tejun Heo wrote:
> 
>> Yeah, right.  The following patch should do the trick then.
> 
> Thanks, I appreciate it.  I get this output:
> 
> XXX PCI_COMMAND=0x407
                    ^

Yeah, that's INTX disable.  Strange that the controller has the bit
set on boot.  I'm curious where this is from, the controller reset,
firmware or the PCI init (in decreasing likelihood).  Hmmm... for now,
I think it would be best to revert the original change.  Jeff, can you
please do that?

Thanks.

-- 
tejun
