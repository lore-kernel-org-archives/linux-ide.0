From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Thu, 30 Nov 2006 05:42:48 -0500
Message-ID: <456EB5A8.2060107@pobox.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0D588DC0@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58838 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935593AbWK3Kmy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 05:42:54 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0D588DC0@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Peer Chen wrote:
> Move the device IDs of MCP65/MCP67 from sata_nv.c to ahci.c.
> The patch will be applied to kernel 2.6.19.
> Please check attachment for the patch.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Please update as follows:

1) Provide a detailed explanation as to /why/ this is needed.  I 
certainly encourage use of ahci over legacy mode, but the patch 
description tells us nothing.

2) Combine the two patches into one.  Think of a patch as an atomic 
operation.  If you apply your patches as submitted, then a 'git bisect' 
may reach a state where the PCI IDs exist in _neither_ sata_nv or ahci. 
  Any time you /move/ code or data, it should be in the same patch.

3) Your patches are completely unreviewable in a standard Internet 
mailer, because they were sent with your email base64-encoded.  For many 
mailers, base64 encoding means the patch is not shown nor able to be 
commented upon.  Indeed, some mailers make it difficult to response -at 
all- to data contained in a MIME attachment.

The change itself seems OK, once suitable justification is provided.

	Jeff


