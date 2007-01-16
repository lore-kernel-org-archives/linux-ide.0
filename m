From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_via: eSATA drive not recognised on VT6421 card
Date: Tue, 16 Jan 2007 11:44:35 +0000
Message-ID: <20070116114435.04e2af42@localhost.localdomain>
References: <011c01c73930$2fdbdce0$181012cb@samson>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46402 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750896AbXAPLcx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 06:32:53 -0500
In-Reply-To: <011c01c73930$2fdbdce0$181012cb@samson>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ray Overdijk <raymov@netro.com.au>
Cc: linux-ide@vger.kernel.org

> ata2: failed to recover some devices, retrying in 5 secs
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2.00: disabled
> 
> uname -r
> 2.6.18-1.2869.fc6xen

Should be fixed in the current upstream code by Tejun's updates and some
workarounds for mode setting.

Alan
