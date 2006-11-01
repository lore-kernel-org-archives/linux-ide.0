From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to
 ahci.c
Date: Tue, 31 Oct 2006 20:37:19 -0500
Message-ID: <4547FA4F.1060209@pobox.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20692 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423625AbWKABhW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 20:37:22 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Peer Chen wrote:
> Resend the patch.
> Signed-off-by: Peer Chen <pchen@nvidia.com>

ACK everything Andrew Morton said:  this patch doesn't apply to the 
current kernel (2.6.19-rc4-gitX).  Please resend.

libata moves fast :)

Also, a related question:  does NVIDIA hardware use the PCI class code 
for AHCI?

	Jeff



