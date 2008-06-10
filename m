From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] Support SB700 SATA controller PMP
Date: Tue, 10 Jun 2008 16:30:50 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E5070A8CF@sshaexmb1.amd.com>
References: <1212659914.6639.12.camel@zm-desktop> <484CBB9E.8010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:56113 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYFJIcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 04:32:15 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <484CBB9E.8010701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

OK, this patch has been merged into the updated SB600 one,
please discard this single SB700 patch.


Thanks
Shane 

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> Sent: Monday, June 09, 2008 1:12 PM
> To: Huang, Shane
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org
> Subject: Re: [PATCH] Support SB700 SATA controller PMP
> 
> Shane Huang wrote:
> > This patch supports SB700 SATA PMP, this patch depends on
> > the SB600 SATA PMP patch sent two days ago.
> > 
> > Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 
> I think this can be rolled into the previous patch when it 
> gets updated
> tho.  Thanks.
> 
> -- 
> tejun
> 
> 

