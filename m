From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] IDE: Add the support of nvidia PATA controllers of
	MCP67 to amd74xx.c & pata_amd.c
Date: Thu, 02 Nov 2006 11:32:20 +0000
Message-ID: <1162467141.11965.160.camel@localhost.localdomain>
References: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA7@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48301 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752855AbWKBL32 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Nov 2006 06:29:28 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA7@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>, akpm@osdl.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

Ar Iau, 2006-11-02 am 11:30 +0800, ysgrifennodd Peer Chen:
> Add support for PATA controllers of MCP67 to amd74xx.c.
> The patch will be applied to kernel 2.6.19-rc4-git1.
> Please check attachment for the patch.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Acked-by: Alan Cox <alan@redhat.com>

Andrew - it would be good if these two patches + ahci one could make
2.6.19 final as they are just ident updates for chipsets.

Alan

