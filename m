From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Date: Thu, 11 Jan 2007 17:51:22 +0100
Message-ID: <58cb370e0701110851r2da0be97pdba5140645cc5bf4@mail.gmail.com>
References: <20070111134917.GE20027@stusta.de>
	 <20070111164853.5de4ddfa@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:25985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXAKQvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 11:51:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so529485uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 08:51:22 -0800 (PST)
In-Reply-To: <20070111164853.5de4ddfa@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/11/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 11 Jan 2007 14:49:17 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
>
> > It's unlikely that this driver will ever be of any use on other
> > architectures.
> >
> > This fixes the following compile error on ia64:
>
> NAK
>
> pci_get_legacy_ide_irq() is a required method for all platforms and is
> usually filled in by asm-generic/pci.h
>
> Please fix the IA64 tree to do the right thing.

I've already sent a patch do do this...

http://lkml.org/lkml/2007/1/11/118
