From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 13:08:11 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E502C6969@sshaexmb1.amd.com>
References: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
 <47BE56AF.1080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:9604 "EHLO
	outbound6-va3-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756460AbYBVFI3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 00:08:29 -0500
Content-class: urn:content-classes:message
In-Reply-To: <47BE56AF.1080808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Su, Henry" <Henry.Su@amd.com>

OMG, but I modified my settings and verified that the patch can really
work here before I sent it to you...


Shane
 

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Friday, February 22, 2008 12:59 PM
> To: Huang, Shane
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; Su, Henry
> Subject: Re: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
> 
> Huang, Shane wrote:
> > Jeff:
> > 
> > SB700 SATA controller can support 64 bit DMA, the previous commit
> > badc2341579511a247f5993865aa68379e283c5c was added with
> > careless reference to SB600, which should be modified by this patch.
> > 
> > 
> > Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> Shane, it still wraps.  Just give up outlook and use thunderbird +
> toggle wordwrap + external editor or mutt/pine.
> 
> -- 
> tejun
> 
> 
> 


