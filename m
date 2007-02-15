From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Fri, 16 Feb 2007 07:46:32 +1100
Message-ID: <1171572392.5644.15.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	 <45D3EAA7.80805@garzik.org>
	 <1171525923.20192.243.camel@localhost.localdomain>
	 <200702151141.49708.jens@de.ibm.com>  <20070215171414.GU923@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58053 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161225AbXBOUwf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 15:52:35 -0500
In-Reply-To: <20070215171414.GU923@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, James K Lewis <jim@jklewis.com>


> I can send a tested patch series (merging all three sources)
> immediately, assuming you like the tree these would be based on. 
> Any special instructions or proceedures to follow, any secret
> initiation rites, hazing, or change of citizenship required?

Just send the blast to our list first so I can verify that the
sungem_phy doesn't adversely affect sungem and everybody (especially Kou
sine you dn't have the Toshiba hardware, do you ?) can verify it all
works fine.

Cheers,
Ben


