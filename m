From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ata_piix can't drive Mac hardware properly
Date: Wed, 28 Mar 2007 05:07:35 +0100
Message-ID: <20070328040735.GA28824@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070328000851.GA25551@srcf.ucam.org> <20070328001610.GB25551@srcf.ucam.org> <20070328011608.GA26913@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:48366 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbXC1EHr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 00:07:47 -0400
Content-Disposition: inline
In-Reply-To: <20070328011608.GA26913@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Wed, Mar 28, 2007 at 02:16:08AM +0100, Matthew Garrett wrote:

> It's ata_read_native_max_address_ext failing, and it's fine if I use 
> ahci rather than ata_piix, so I'll just chalk this up to Apple's 
> firmware being broken (again) and putting the hardware into some sort of 
> "I can't believe it's not piix" mode and see what I can do about 
> ensuring we use ahci instead.

Slightly oddly, with ata_piix it seems to be failing with AC_ERR_HSM. 
Any idea why that might be?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
