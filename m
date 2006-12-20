From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Wed, 20 Dec 2006 14:19:32 -0500
Message-ID: <45898CC4.9010805@pobox.com>
References: <15F501D1A78BD343BE8F4D8DB854566B07FC61A9@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34918 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030304AbWLTTTg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Dec 2006 14:19:36 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B07FC61A9@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Peer Chen wrote:
> Resend the patch.
> The content of memory map io of BAR5 have been change from MCP65 then sata_nv can't work fine on the platform based on MCP65 and MCP67,so move their IDs from sata_nv.c to ahci.c.
> Please check attachment for new patch,thanks.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Patch applied, manually.

For future patches,

1) Please do not quote the original message

2) Please include patches inline, rather than as an attachment.

	Jeff



