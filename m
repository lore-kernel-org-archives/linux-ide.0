From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc2 - Cable detection problem in pata_amd
Date: Tue, 24 Oct 2006 15:08:59 +0100
Message-ID: <1161698939.22348.33.camel@localhost.localdomain>
References: <453D5067.9070407@lorettotel.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61420 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161094AbWJXOFv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Oct 2006 10:05:51 -0400
In-Reply-To: <453D5067.9070407@lorettotel.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Walt H <walt_h@lorettotel.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Ar Llu, 2006-10-23 am 18:29 -0500, ysgrifennodd Walt H:
> On bootup, the pata_amd driver mis-detects the cable connected to the
> 2nd port on my system as 40 wire and sets UDMA/33 for this drive. Prior

Can you stick it in bugzilla.kernel.org and assign it to me. Also attach
an lspci -vxxx. There is a bug or two somewhere in this area still but
I'm very busy at the moment with other stuff so don't want your report
to go in one ear and out of the other in a couple of days then get
forgotten.


