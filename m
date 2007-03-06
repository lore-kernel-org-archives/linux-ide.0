From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 26/30] Support for Marvell 7042 Chip
Date: Tue, 06 Mar 2007 07:01:41 -0500
Message-ID: <45ED5825.2000605@garzik.org>
References: <200703061038.l26AcBaO019542@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53750 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231AbXCFMBp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 07:01:45 -0500
In-Reply-To: <200703061038.l26AcBaO019542@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, tmorrison@empirix.com

akpm@linux-foundation.org wrote:
> From: "Morrison, Tom" <tmorrison@empirix.com>
> 
> Added Support for Marvell 7042 Chip - 7042 has same capabilities & behavior
> as 6042.
> 
> Signed-off-by: Thomas A. Morrison <tmorrison@empirix.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_mv.c |    3 +++
>  1 file changed, 3 insertions(+)

applied, although it's questionable whether this works at all on PCI-Express


