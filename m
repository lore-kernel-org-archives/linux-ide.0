From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.23-rc1: pata_via cable detection differs from via82cxxx
Date: Sat, 4 Aug 2007 01:12:01 +0200
Message-ID: <200708040112.01486.bzolnier@gmail.com>
References: <200708031828.l73ISdY9022725@harpo.it.uu.se> <20070803233217.54c82022@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:9108 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486AbXHCXM6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 19:12:58 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1189023mue
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 16:12:57 -0700 (PDT)
In-Reply-To: <20070803233217.54c82022@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Saturday 04 August 2007, Alan Cox wrote:
> On Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
> Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
> > The machine is an Athlon64 laptop with a K8T800 chipset. With the IDE
> > VIA driver the disk is detected as udma/100:
> 
> Currently old IDE via driver has a hack in it which goes 'did the BIOS
> set UDMA3+' then I guess the cable is 80 wire regardless. libata doesn't
> do that as it breaks with hotplug, breaks with suspend/resume before the
> driver is loaded and other bits.
> 
> Instead we have two things - an ACPI snoop and a table of wonky laptops
> (eg those that use 40 wire ultrashort cables which are valid for UDMA133
> but not detected as 80 wire). If your laptop is done that way then it
> just needs adding to the magic list and/or 2.6.23-rc1-mm should spot it
> by ACPI. I'd prefer the table entry anyway as I don't like relying on ACPI
> so an lspci -vvxx would be appreciated

Please also add it to the laptop table in IDE VIA driver.

Thanks,
Bart
