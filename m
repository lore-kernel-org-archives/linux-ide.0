From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: [PATCH 5/5]: [PCI]: Remove 3 incorrect MSI quirks.
Date: Mon, 29 Oct 2007 14:06:16 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A50705623160@sshaexmb1.amd.com>
References: <20071025.011716.123998434.davem@davemloft.net>
 <9783dadb0710260356g4ef94e3dvadf69d4d263c2361@mail.gmail.com>
 <20071026.043833.88113848.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:20335 "EHLO
	outbound7-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994AbXJ2GGh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 02:06:37 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20071026.043833.88113848.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, david.gaarenstroom@gmail.com, htejun@gmail.com
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, gregkh@suse.de, brice.goglin@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com, Shane Huang <Shane.Huang@amd.com>


> I would like those to be removed, but to be conservative we should
> first get some testing feedback that confirms this just like those
> provided to me from the AMD folks for the RS690, RX790 and RD580
> cases.
> 
> Otherwise the risk to break people's systems is very real.

In fact, our team only has boards with RS690+SB700 and RX790+SB700,
I don't know why the RD580 MSI is disabled too by the patch
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=aea6a433f50cd89b9cbd10850fd0b32f961f9883
Maybe Tejun can give us more information on this case,
I think the cause should be same as RS690 and RX790.

If you need some small test on USB issue related with RS480 or
something else, you may tell me, I can try to ask the help from our
SW QA or test by myself, if we can find out such test platform.

Thanks
Shane



