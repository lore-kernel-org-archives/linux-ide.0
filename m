From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/PATCH] ia64, SR870, EFI bug breaks ata_piix, uninitialized
 ICH4 IDE EXBAR mem resource
Date: Mon, 17 Sep 2012 11:56:19 +0100
Message-ID: <20120917115619.13d3a3cb@pyramind.ukuu.org.uk>
References: <20120916183914.Horde._TGALdjz9kRQVgCy6ATxxJA@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120916183914.Horde._TGALdjz9kRQVgCy6ATxxJA@webmail.df.eu>
Sender: linux-pci-owner@vger.kernel.org
To: Stephan Schreiber <info@fs-driver.org>
Cc: linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 679545@bugs.debian.org, jrnieder@gmail.com
List-Id: linux-ide@vger.kernel.org

My only disagreement here would be putting it in the ia64 paths. If
someone does the same for x86-32 (and this is EFI so it'll presumbly
smell the same on all platforms) then we'll want the same.

Better I think to generically catch the 0/0 case.

Alan
