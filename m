From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Mon, 14 May 2007 18:06:41 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B13CD865E@hkemmail01.nvidia.com>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net> <46445833.7050707@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B13B96E68@hkemmail01.nvidia.com> <46482BE1.4060309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:14532 "EHLO
	HQEMGATE01.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbXENKHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 06:07:09 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46482BE1.4060309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org

As following, the scr registers' offset in sata_nv driver is 0x0 & 0x40,
but offset 0x0 in BAR5 memory map of AHCI controller is 'HBA
Capabilities register', the value of this register make the driver
believe there is always a HD drive being connected to port0,so error
happen.
==============================================
	NV_PORT0_SCR_REG_OFFSET		= 0x00,
	NV_PORT1_SCR_REG_OFFSET		= 0x40, 


BRs
Peer Chen

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Monday, May 14, 2007 5:29 PM
To: Peer Chen
Cc: akpm@linux-foundation.org; jeff@garzik.org;
linux-ide@vger.kernel.org
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv
driver

Hello,

Peer Chen wrote:
> Tejun,
> The future nvidia chips are all base on AHCI and also they can support
> compatible mode,but current sata_nv have the bug with compatible mode
> for AHCI controller,we need to modify the sata_nv driver then submit
the
> patch.

Yes, please do that.

> Before that,if users load the sata_nv driver for our AHCI
> controllers,they will encounter that bug.

What kind of bug are we talking about?

Thanks.

-- 
tejun
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
