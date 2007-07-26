From: Craig Block <chblock3@yahoo.com>
Subject: Re: Problems with nVidia nForce 520 Chipset
Date: Thu, 26 Jul 2007 10:07:38 -0700 (PDT)
Message-ID: <5970.47045.qm@web58101.mail.re3.yahoo.com>
References: <46A85AD0.2070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web58101.mail.re3.yahoo.com ([68.142.236.124]:30528 "HELO
	web58101.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760741AbXGZRHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 13:07:40 -0400
In-Reply-To: <46A85AD0.2070905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:
>
> Craig Block wrote:
> > 
> > I'm having a problem getting Linux to handle the SATA drives and
> > controllers on a new computer with an ASUS M2N-X motherboard.  This is a 
> > socket AM2 board and has an nVidia nForce 520 chipset.
> 
> Does 'noapic' kernel parameter help?

Unfortunately, no.  I also tried noapic with nolapic, nomsi, and pci=nobios.  

I believe it boils down to the following line I'm seeing in the dmesg output;  

ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Thanks


       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC
