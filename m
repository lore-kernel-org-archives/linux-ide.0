From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Removing PCI dependency of ahci and making it amba bus
 	compatible
Date: Fri, 27 Mar 2009 10:08:20 +0900
Message-ID: <49CC2704.7050102@kernel.org>
References: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55604 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934189AbZC0BI3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Mar 2009 21:08:29 -0400
In-Reply-To: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Sagar Borikar wrote:
> Currently  ahci driver assumes that the SATA controller is hooked up
> to the PCI. There are couple of devices like Synopsis Designware SATA
> controller with ahci sits on AHB interface and not on PCI. This patch
> is currently tied up to our platform and I have removed PCI dependent
> calls from the the driver. I still have to make it bus independent.
> Please review the patch and let me know if its fine.
> 
> All comments are welcome. Also please note that this is not
> replacement of the existing ahci.c file I am going to create a new
> file for ahci_ahb.c But for review, I have compared against ahci.c
> Thanks

Sagar, the amba changes look fine although I have no way of verifying
whether it works or not, but you just converted ahci from pci
dependent to amba dependent.  The patch can't really be merged unless
we're willing to break all PCI ahci systems in favor of the amba one.
:-)

Are you interested in properly factoring out the common part and allow
both pci and amba to use it?  You've already identified all the
necessary parts, so that's a pretty good starting point.

Thanks.

-- 
tejun
