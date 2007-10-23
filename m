From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata VIA New ID
Date: Tue, 23 Oct 2007 16:52:38 +0900
Message-ID: <471DA846.8060709@gmail.com>
References: <63379.201.21.145.69.1191620918.squirrel@webmail.sistemafenix.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:49631 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXJWHws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 03:52:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1416833rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 00:52:47 -0700 (PDT)
In-Reply-To: <63379.201.21.145.69.1191620918.squirrel@webmail.sistemafenix.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gilberto@sistemafenix.com.br
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

gilberto@sistemafenix.com.br wrote:
> Hi, my name is Gilberto I am from of the distribuition linux call FeniX
> Linux in Brazil.
> I need your help, I need put in sata_via.c a new ID for hd sata in my
> kernel 2.6.20.7
> I need only put the new id or I need make more things
> 
> The Gigabyte from Brasil, put for sale a new model call GA-VM900M with
> sata 2, In new kernel 2.6.22-9 its working. But I have some drivers
> compiled for my kernel its impossible change the version of the kernel,
> only because new SATA2
> 
> And some manufetures of Desktops are with problems because this.
> 
> 
> static const struct pci_device_id svia_pci_tbl[] = {
> 	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
> 	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
> 	{ PCI_VDEVICE(VIA, 0x3149), vt6420 },
> 	{ PCI_VDEVICE(VIA, 0x3249), vt6421 },
> 	{ PCI_VDEVICE(VIA, 0x5372), vt6420 },    ***** I put this line only ****
> 
> 
> 	{ }	/* terminate list */
> };
> 
> What do I need for resolve this problem....

The change is included in 2.6.23.

-- 
tejun
