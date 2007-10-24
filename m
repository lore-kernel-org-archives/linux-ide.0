From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ata:  sata_nv MCP61 using GENERIC instead of SWNCQ
Date: Tue, 23 Oct 2007 23:43:41 -0700
Message-ID: <20071023234341.211905bf.akpm@linux-foundation.org>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39544 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753036AbXJXGoV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 02:44:21 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

On Mon, 22 Oct 2007 14:00:56 +0800 "Kuan Luo" <kluo@nvidia.com> wrote:

> 	The mcp61 has bug with ncq. The patch only changes SWNCQ to
> GENERIC  on MCP61 in nv_pci_tbl structure.

Please include a Signed-off-by: in your patches, as per
Documentation/SubmittingPatches, thanks.
