From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [SATA] max-sect and sii-m15w branches merged
Date: Thu, 10 Aug 2006 13:41:30 +0100
Message-ID: <1155213691.22922.8.camel@localhost.localdomain>
References: <44DB106C.6090504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18581 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751493AbWHJMVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 08:21:43 -0400
In-Reply-To: <44DB106C.6090504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Ar Iau, 2006-08-10 am 06:54 -0400, ysgrifennodd Jeff Garzik:
> I just merged the max-sect and sii-m15w branches into the upstream branch.
> 
> This means that the following two changes are queued for 2.6.19:
> 
> * increase max sectors from 200 to 256 (for lba28)
> * better mod15write support for sata_sil

Great. I'll retest the IT821x once I've got a moment to pull an up to
date tree.

