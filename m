From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: [PATCH] ata:  sata_nv MCP61 using GENERIC instead of SWNCQ
Date: Thu, 25 Oct 2007 14:02:17 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1D6@hkemmail01.nvidia.com>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com> <472028EE.7030007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:2929 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbXJYGC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 02:02:56 -0400
In-Reply-To: <472028EE.7030007@garzik.org>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

jeff wrote:
> Kuan Luo wrote:
> > hi, 
> > 	The mcp61 has bug with ncq. The patch only changes SWNCQ to
> > GENERIC  on MCP61 in nv_pci_tbl structure.
> 
> Do I have your permission to merge this patch with a
> 
> 	Signed-off-by: Kuan Luo <kluo@nvidia.com>
> 
> ?
> 
> Each patch needs a Signed-off-By line, which essentially provides a 
> legal release to the patch.  See "Developer's Certificate of 
> Origin" in 
> Documentation/SubmittingPatches or
> http://linux.yyz.us/patch-format.html
> 
> 	Jeff
> 
> 
>
Yes, you can merge Signed-off-by: Kuan Luo <kluo@nvidia.com>. 
Next time  i will sumbit the patch according completely with the patch
format.

Best regards,
Kuan Luo
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
