From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Date: Tue, 28 Nov 2006 03:39:29 -0500
Message-ID: <456BF5C1.9010506@garzik.org>
References: <4569F703.8010209@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63617 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1756991AbWK1Ijc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 03:39:32 -0500
In-Reply-To: <4569F703.8010209@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Nicolas.Mailhot@LaPoste.net

Robert Hancock wrote:
> The attached patch against 2.6.19-rc6-mm1 fixes some problems in sata_nv 
> with ATAPI devices on controllers running in ADMA mode. Some of the 
> logic in the nv_adma_bmdma_* functions was inverted causing a bunch of 
> warnings and caused those functions not to work properly. Also, when an 
> ATAPI device is connected, we need to use the legacy DMA engine. The 
> code now disables the PCI configuration register bits for ADMA so that 
> this works, and ensures that no ATAPI DMA commands go through until this 
> is done.
> 
> Fixes Bugzilla http://bugzilla.kernel.org/show_bug.cgi?id=7538
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied

In the future, please use "---" not "--" as the separator your .sig, so 
that it is not copied into the kernel changelog by git-applymbox.

also, please avoid MIME attachments and include the patch inline.


