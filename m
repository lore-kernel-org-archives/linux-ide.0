From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: no dma support dvd-rom toughbook cf-y5 ata_piix
Date: Fri, 12 Jun 2009 00:54:39 -0600
Message-ID: <4A31FBAF.8010605@gmail.com>
References: <1244700488.4142.3.camel@crystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:42726 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZFLGyk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 02:54:40 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1363521ywb.1
        for <linux-ide@vger.kernel.org>; Thu, 11 Jun 2009 23:54:42 -0700 (PDT)
In-Reply-To: <1244700488.4142.3.camel@crystal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: discord@u.washington.edu
Cc: linux-ide@vger.kernel.org

On 06/11/2009 12:08 AM, Colin Williams wrote:
> I filed a bug on ubuntu launchpad
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/357531.
>
> Is it indeed a bug? Is their some kind of module flag or patch? Is their
> a way to enable dma on my dvd-rom? I'd love to watch dvd's on my laptop
> can one of module developers give me some insight?

Doesn't look like the DVD-ROM is connected via PATA or SATA, looks like 
it's actually connected via a USB connection internally? That seems a 
bit bizarre.. Can you do a lsusb to verify if that's the case?

If it is, then the kernel doesn't have any control over the DMA state of 
the drive, as that's purely under control of the USB-to-ATA bridge chip 
they're presumably using.
