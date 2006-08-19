From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [RESEND][PATCH] sata_via: Add SATA support for vt8237a
Date: Sat, 19 Aug 2006 19:25:54 +0100
Message-ID: <20060819182553.GA11985@unjust.cyrius.com>
References: <20060814031030.GA3088@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:2572 "EHLO sorrow.cyrius.com")
	by vger.kernel.org with ESMTP id S1750981AbWHSSZ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Aug 2006 14:25:57 -0400
Content-Disposition: inline
In-Reply-To: <20060814031030.GA3088@osprey.hogchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: Jay Cliburn <jacliburn@bellsouth.net>

* Jay Cliburn <jacliburn@bellsouth.net> [2006-08-13 22:10]:
> This patch adds support for the VIA Technologies VT8237A SATA controller.
> 
> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
> 
>  static const struct pci_device_id svia_pci_tbl[] = {
> +	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>  	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>  	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },

What's the status of this patch?  Someone just reported a bug to
Debian saying that their controller is not supported and that this
patch works.
-- 
Martin Michlmayr
tbm@cyrius.com
