From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sun, 3 Feb 2008 10:59:48 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B1BFE2ADB@hkemmail01.nvidia.com>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com> <20080202173723.GA26461@solitudo.net> <47A4F956.6030005@gmail.com> <47A50249.2080902@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:4155 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYBCC7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 21:59:53 -0500
In-Reply-To: <47A50249.2080902@shaw.ca>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Tejun Heo <htejun@gmail.com>
Cc: Tuomas Jormola <tj@solitudo.net>, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

robert wrote:
> Tejun Heo wrote:
> > Tuomas Jormola wrote:
> >> 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 
> SATA Controller [10de:03f6] (rev a2)
> >> 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 
> SATA Controller [10de:03f6] (rev a2)
> > 
> > That's MCP61 which is GENERIC variant in sata_nv which does 
> not support
> > hotplugging.  Robert, is this hardware restriction or do we 
> just need
> > more info?
> 
> Well, MCP61 originally supported SWNCQ which includes hotplug 
> support. 
> However, SWNCQ was later disabled on MCP61 due to hardware 
> bugs. NVIDIA 
> guys, it is possible to still use hotplug on MCP61?
> 

Yes, it needs to add some code to support hotplug without swncq.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
