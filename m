From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Mon, 14 May 2007 11:29:05 +0200
Message-ID: <46482BE1.4060309@gmail.com>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net> <46445833.7050707@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B13B96E68@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:65269 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbXENJ3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 05:29:35 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1748154nzf
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 02:29:34 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B13B96E68@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org

Hello,

Peer Chen wrote:
> Tejun,
> The future nvidia chips are all base on AHCI and also they can support
> compatible mode,but current sata_nv have the bug with compatible mode
> for AHCI controller,we need to modify the sata_nv driver then submit the
> patch.

Yes, please do that.

> Before that,if users load the sata_nv driver for our AHCI
> controllers,they will encounter that bug.

What kind of bug are we talking about?

Thanks.

-- 
tejun
