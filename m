From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Patch] IDE: Add nvidia IDE controller of MCP67 support to
	amd74xx.c
Date: Tue, 31 Oct 2006 09:29:52 +0000
Message-ID: <1162286992.11965.31.camel@localhost.localdomain>
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D5A1@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423011AbWJaJ0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 04:26:23 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D5A1@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Maw, 2006-10-31 am 16:03 +0800, ysgrifennodd Peer Chen:
> Add the support for IDE controller of MCP67.
> The following amd74xx.c patch is based on kernel 2.6.18.
> 
> Signed-off by: Peer Chen <pchen@nvidia.com>

For current kernels you need to update both drivers/ide/ and drivers/ata
pata drivers for AMD/Nvidia.

Alan

