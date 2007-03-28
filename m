From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: HPA patches
Date: Wed, 28 Mar 2007 01:16:10 +0100
Message-ID: <20070328001610.GB25551@srcf.ucam.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070328000851.GA25551@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:38280 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965365AbXC1AQ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 20:16:26 -0400
Content-Disposition: inline
In-Reply-To: <20070328000851.GA25551@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Wed, Mar 28, 2007 at 01:08:52AM +0100, Matthew Garrett wrote:
> ata3.01: ata_hpa_resize 1: sectors = 234441648, hpa_sectors = 0
                                                                ^
Does this just indicate the lack of an hpa? If so, the

/* if no hpa, both should be equal */

comment seems to be wrong (or, alternatively, it's the 
ata_read_native_max_address_ext call that's failing and returning 
garbage? I'll look into that)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
