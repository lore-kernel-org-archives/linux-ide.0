From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata:  sata_nv MCP61 using GENERIC instead of SWNCQ
Date: Thu, 25 Oct 2007 02:15:29 -0400
Message-ID: <47203481.7080102@garzik.org>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54514 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbXJYGPc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:15:32 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B059FE1CF@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

Kuan Luo wrote:
> hi, 
> 	The mcp61 has bug with ncq. The patch only changes SWNCQ to
> GENERIC  on MCP61 in nv_pci_tbl structure.

applied


