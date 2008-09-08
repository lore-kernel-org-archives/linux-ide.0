From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Mon, 8 Sep 2008 09:43:32 +0100
Message-ID: <20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
References: <48C45BEF.5090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60812 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbYIHInt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 04:43:49 -0400
In-Reply-To: <48C45BEF.5090502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Cc: linux-ide@vger.kernel.org

> Netvista will complain with the messages bellow, using kernel 2.6.24.7
> (i haven't used any more recent kernel because since kernel 2.6.24.7
> they just fail to boot in Netvista 8363).

What was the last kernel that did boot correctly ?
If you are using a CF/ATA adapter do you have one which is rated for
UDMA ?
Does 2.6.24.7 work with CS5530=n and CONFIG_PATA_CS5530 enabled instead ?
(If it doesn't then the different diagnostics will be useful)

Alan
