From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Mon, 14 May 2007 12:10:17 +0200
Message-ID: <46483589.3060105@gmail.com>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net> <46445833.7050707@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B13B96E68@hkemmail01.nvidia.com> <46482BE1.4060309@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B13CD865E@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:22389 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbXENKL0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 06:11:26 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1757446nzf
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 03:11:25 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B13CD865E@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org

Peer Chen wrote:
> As following, the scr registers' offset in sata_nv driver is 0x0 & 0x40,
> but offset 0x0 in BAR5 memory map of AHCI controller is 'HBA
> Capabilities register', the value of this register make the driver
> believe there is always a HD drive being connected to port0,so error
> happen.
> ==============================================
> 	NV_PORT0_SCR_REG_OFFSET		= 0x00,
> 	NV_PORT1_SCR_REG_OFFSET		= 0x40, 

OIC, no objection to the original patch and please fix this one.

Thanks.

-- 
tejun
