From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 09:23:24 +0100
Message-ID: <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54622 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755947AbZFYIVv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 04:21:51 -0400
In-Reply-To: <323951117.20090625100956@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

On Thu, 25 Jun 2009 10:09:56 +0200
Andrei Martynov <andrei.martynov@web.de> wrote:

> Hi,
> 
> I'm porting Sigma IDE driver for EM85XX chipset from 2.4.17 to 2.6
> kernel for an open-source project. Is there any upgrade guide
> available? If not, what are the modern ATA equivalents for old
> ide_dma_off, ide_dma_off_quietly and ide_dma_test_irq commands?

Are you trying to port it to the legacy IDE code in 2.6 or to libata ?
