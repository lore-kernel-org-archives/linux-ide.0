From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: readXs on pci*iomap-ped regions [Was: [PATCH] /drivers/char sx.c
 ioremap -> pci_ioremap api]
Date: Sat, 25 Aug 2007 11:02:44 +0200
Message-ID: <46CFF034.1030403@gmail.com>
References: <46CF2849.2090008@gmail.com> <4af2d03a0708241159v56b46299h46df9777a98590e5@mail.gmail.com> <20070824201530.5d741b37@the-village.bc.nu>	<46CF399E.3010808@gmail.com> <20070824213439.0007e653@the-village.bc.nu> <46CFEC40.7060006@gmail.com> <46CFEEB3.6000802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933914AbXHYJB5@vger.kernel.org>
In-Reply-To: <46CFEEB3.6000802@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: linux-ide@vger.kernel.org

Jeff Garzik napsal(a):
> If the driver knows its MMIO, using readX/writeX after pci_iomap() is
> just fine, for all current implementations, and it makes sense that way.

Hmm, that's what I'm claiming.

-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
