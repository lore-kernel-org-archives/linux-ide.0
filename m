From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: remove broken hpt34x driver
Date: Thu, 16 Oct 2008 11:18:51 +0100
Message-ID: <20081016111851.4f519c58@lxorguk.ukuu.org.uk>
References: <200810152156.25754.bzolnier@gmail.com>
	<48F70DDA.4010805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44983 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbYJPKTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 06:19:04 -0400
In-Reply-To: <48F70DDA.4010805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 16 Oct 2008 13:48:10 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > No big loss since HPT343/363 controllers are properly supported
> > by pata_hpt3x3 driver from Alan Cox.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> 
>    Hum, interesting way of fixing the driver... :-)
>    Shouldn't the PCI IDs be added to drivers/ide/pci/generic.c?

Won't work. The device isn't actually generic IDE. You have to sort the
register mappings out and use the right mapping window for the chip to
work.
