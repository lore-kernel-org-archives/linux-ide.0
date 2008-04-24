From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Thu, 24 Apr 2008 16:15:14 +0100
Message-ID: <20080424161514.0e9c35b9@the-village.bc.nu>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi>
	<480DE3C4.5@ru.mvista.com>
	<480DE6F5.8060403@gmail.com>
	<480DE9E8.2070809@ru.mvista.com>
	<480DEB1F.5060500@gmail.com>
	<20080424123541.09e5ef96@the-village.bc.nu>
	<481080EA.7010107@ru.mvista.com>
	<20080424152758.789e024c@the-village.bc.nu>
	<4810A780.9040508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51396 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763993AbYDXPn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 11:43:59 -0400
In-Reply-To: <4810A780.9040508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>     You probaly mean PC targeted controllers, since quite many non-PC chips do 
> ignore that spec (IOC4, PowerMac, Toshiba SCC)... As for CS5520, what's the 
> deviation here -- BMDMA regisrters at BAR2 only?

BMDMA at BAR 2, different class code, IDE side effectively not PCI (as
with the MPIIX)

Alan
