From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: HPA patches
Date: Wed, 28 Mar 2007 22:28:29 +0100
Message-ID: <20070328212829.GA14263@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070328000851.GA25551@srcf.ucam.org> <20070328105754.72b578bd@the-village.bc.nu> <20070328200829.GA12776@srcf.ucam.org> <20070328225431.69d0a3cc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:55461 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbXC1V2k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 17:28:40 -0400
Content-Disposition: inline
In-Reply-To: <20070328225431.69d0a3cc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Wed, Mar 28, 2007 at 10:54:31PM +0100, Alan Cox wrote:

> I wonder if the firmware is dying when we ask the disk to go zero sized
> rather than erroring politely. I'm not sure hth HPA sectors can come back
> as zero but we can be fairly sure 0 means "no HPA" in this case I guess ?

No, it seems to be looking at 0 because ata_read_native_max_address_ext 
returns 0 in the error case - the error that ata_exec_internal generates 
seems to be AC_ERR_HSM. Since 0 isn't > the size reported, we'll never 
try to resize it anyway, judging by ata_hpa_resize - that is, it seems 
to be the ata_read_native_max_address_ext call that breaks it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
