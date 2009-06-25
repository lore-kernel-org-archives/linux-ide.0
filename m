From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 10:05:42 +0100
Message-ID: <20090625100542.525dba02@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
	<14164712.20090625103834@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57072 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756493AbZFYJEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 05:04:09 -0400
In-Reply-To: <14164712.20090625103834@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

On Thu, 25 Jun 2009 10:38:34 +0200
Andrei Martynov <andrei.martynov@web.de> wrote:

> Hi Alan,
> 
> Thursday, June 25, 2009, 10:23:24 AM, you wrote:
> 
> >> I'm porting Sigma IDE driver for EM85XX chipset from 2.4.17 to 2.6
> 
> > Are you trying to port it to the legacy IDE code in 2.6 or to libata ?
> 
> I'm trying to port it to libata. My PATA driver already supports EM8511
> chipset but I constantly get errors on EM8500 chipset.

Assuming you are using the standard qc_issue (ie you've not overridden it)
then:

bmdma_setup is called at the start of the DMA command
bmdma_start is called to begin a DMA transfer
bmdma_stop is called to end one

For ATA you get

	bmdma_setup
	bmdma_start
	DMA
	bmdma_stop

for ATAPI

	bmdma_setup
	PIO CDB
	bmdma_start
	bmdma_stop


Also related to this is check_atapi_dma which is passed a potential ATAPI
command and you can return zero for OK for DMA or an error to make the
kernel switch that command to PIO.

