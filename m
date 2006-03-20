From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates
Date: Mon, 20 Mar 2006 16:35:56 +0000
Message-ID: <1142872556.21455.7.camel@localhost.localdomain>
References: <20060320111658.GA16172@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751146AbWCTQ3N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Mar 2006 11:29:13 -0500
In-Reply-To: <20060320111658.GA16172@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Llu, 2006-03-20 at 06:16 -0500, Jeff Garzik wrote:
> Jeff Garzik:
>       [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.

This is a most confusing choice as 80% of the file has nothing to do
with bus mastering DMA, and a large amount of it has nothing to do with
PCI either. Also lots of DMA stuff is in the drivers so all the new bus
mastering drivers don't use bmdma.c

The split makes sense, the choice of name is peculiar, if not completely
broken 8)

Alan

