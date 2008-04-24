From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Thu, 24 Apr 2008 15:27:58 +0100
Message-ID: <20080424152758.789e024c@the-village.bc.nu>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi>
	<480DE3C4.5@ru.mvista.com>
	<480DE6F5.8060403@gmail.com>
	<480DE9E8.2070809@ru.mvista.com>
	<480DEB1F.5060500@gmail.com>
	<20080424123541.09e5ef96@the-village.bc.nu>
	<481080EA.7010107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758909AbYDXO66@vger.kernel.org>
In-Reply-To: <481080EA.7010107@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>     If you mean SFF-8038i (which can indeed be named "SFF/Intel"), it
> documents *only* BMDMA.  If you mean something else, please be more precise.

It documents where the PIO spaces are mapped, the class codes and then
documents the rest by inheriting it from the other specs. That makes it
the definitive spec for PCI "standard" controllers both PIO and DMA and
it is indeed followed literally by just about every PCI ATA controller
except the CS5520

Alan
