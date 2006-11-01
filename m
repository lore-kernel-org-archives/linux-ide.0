From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67support
 to sata_nv.c
Date: Wed, 01 Nov 2006 04:47:51 -0500
Message-ID: <45486D47.9020803@pobox.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C54F590@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47590 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946738AbWKAJr7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 04:47:59 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C54F590@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Peer Chen wrote:
> Attached the patch cause my mail client always wrap the plain text format.
> Check attachment for patch,thanks.

Need one more modification:

It is the libata policy to prefer use of numeric hexidecimal constants
for the PCI device id, rather than always defining a symbol in
include/linux/pci_ids.h.  The PCI device ID is a single-use "magic
number" that is only used in the PCI ID table.

Therefore, when your patch changes the hex numbers to constants, it is
reversing that policy.

Instead, please submit a patch that simply adds more hexidecimal PCI
device ids.

	Jeff



