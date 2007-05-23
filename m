From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.6.21.1: ide-pci is not finding ide controller.
Date: Wed, 23 May 2007 21:24:25 +0100
Message-ID: <20070523212425.68897280@the-village.bc.nu>
References: <20070523201118.GZ5921@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38209 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756164AbXEWUTi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 16:19:38 -0400
In-Reply-To: <20070523201118.GZ5921@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 23 May 2007 15:11:18 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> I've got a rather old x86 box that I'm booting 2.6.21.1 on;
> this kernel is not finding an ide controller on it. 

HPT366 fixes were posted here earlier. It doesn't in fact have reliable
enable bits.
