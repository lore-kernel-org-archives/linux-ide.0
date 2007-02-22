From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about PATA Sil680 Cache Line Size and Performance
 Degradation on ARM XScale
Date: Thu, 22 Feb 2007 18:52:02 +0000
Message-ID: <20070222185202.03121afc@lxorguk.ukuu.org.uk>
References: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>
	<20070222000400.2c220b8f@lxorguk.ukuu.org.uk>
	<8202f4270702211721o1629aa63q3670823b7348df1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51989 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbXBVRsM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 12:48:12 -0500
In-Reply-To: <8202f4270702211721o1629aa63q3670823b7348df1f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

> Since Sil3124 has better PCI read/write performance, as a reference,
> could someone explain or point me to the PCI configuration code for
> Sil3124? I couldn't find it in sata_sil24.c.

Are you sure the values used are not the power on ones in this case ?

