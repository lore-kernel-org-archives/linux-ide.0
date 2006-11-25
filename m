From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
Date: Sat, 25 Nov 2006 16:03:42 +0000
Message-ID: <20061125160342.4e9ddef0@localhost.localdomain>
References: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757931AbWKYP5V@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/33

Looks like a cable detect error.

> scsi1 : pata_via
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: port failed to respond (30 secs, Status 0xff)
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)

This is a known bug in the libata core at the moment

> BTW: is it possible to do something with this annoying long delay with 
> the "port is slow to respond, please be patient" message? :)

No, but it does appear to be a bug. Can you send me an lspci -vvxxx

Alan
