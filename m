From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Tue, 06 Oct 2009 20:21:15 +0200
Message-ID: <m38wfoxu1w.fsf@intrepid.localdomain>
References: <m3my46yo5g.fsf@intrepid.localdomain>
	<19146.1202.511428.691521@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933054AbZJFSV4@vger.kernel.org>
In-Reply-To: <19146.1202.511428.691521@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Mon, 5 Oct 2009 16:37:38 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> Try again with a known good SATA disk instead of the SSD.

Will do.

> What is the make and model of that mini-PCI card?

It's Commell MP-6421:
http://www.commell.com.tw/product/Peripheral/MiniPCI/MP-6421.HTM

I wonder if the BIOS (which isn't used on IXP4xx) does some fixups to
this chip?
-- 
Krzysztof Halasa
