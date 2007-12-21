From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via question.
Date: Fri, 21 Dec 2007 13:48:44 +0000
Message-ID: <20071221134844.1b58fbcd@the-village.bc.nu>
References: <200712210755.52792.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34615 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016AbXLUN4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 08:56:12 -0500
In-Reply-To: <200712210755.52792.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

> Or is it all covered by this:  from lspci, with or without pata_via loaded
> 
> 01:0a.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller 
> (rev 50)

sata_via handles the extra pata_port on this controller
