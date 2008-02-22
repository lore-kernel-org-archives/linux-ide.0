From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 19:03:15 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E502C6B38@sshaexmb1.amd.com>
References: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
 <20080222093214.00ab5c58@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:31399 "EHLO
	outbound5-va3-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbYBVLDg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 06:03:36 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20080222093214.00ab5c58@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, "Su, Henry" <Henry.Su@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Alan:
 

> > SB700 SATA controller can support 64 bit DMA, the previous commit
> > badc2341579511a247f5993865aa68379e283c5c was added with
> > careless reference to SB600, which should be modified by this patch.
> 
> Does the SB700 have the same limits as the SB600 on 256 sectors in one
> PRD entry ? If it does then this change needs to wait until the
> workaround for that is included.


Thanks for the reminder, but that issue only appears on SB600,
while SB700 does not have that limitation. I'll submit this
SB700/800 patch again with a private mail box later.


Thanks
Shane


