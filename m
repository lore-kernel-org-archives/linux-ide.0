From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 0/2] libata: implement 32-bit transfers for PIO mode
Date: Mon, 18 Feb 2008 00:08:00 +0100
Message-ID: <20080217230800.GA15374@1wt.eu>
References: <20080217211810.GA15001@1wt.eu> <20080217223134.1c61809b@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:2021 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668AbYBQXIN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Feb 2008 18:08:13 -0500
Content-Disposition: inline
In-Reply-To: <20080217223134.1c61809b@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 17, 2008 at 10:31:34PM +0000, Alan Cox wrote:
> > Thus, I have implemented the 32-bit mode to bring the performance back
> > to the level of the old IDE driver. I jumped from 1.5 MB/s to 2.5 MB/s,
> > which is an important difference at this level of performance, especially
> > when large files are read. The 32-bit mode is enabled using the ioctl
> > which is already implemented but only accepts a null value.
> 
> Excellent, that has been on my TODO list for some time and I'd only
> gotten as far as putting into the ISA/VLB drivers rather than generally
> testing.
> 
> I'm not however sure this should be a DFLAG but should be an alernative
> ata_data_xfer method - I say that because VLB needs to wrap it and some
> controllers have quirky rules for 32bit xfers. (Also some small number of
> pre ATA disks can't handle the different timing cycles from a 32bit ISA
> I/O being redirected their way).

Do you think this can cause any trouble considering that default setting
is not changed ? However, I agree that an alternative ata_data_xfer may
make it easier to always enable it on some controllers. Or maybe we should
keep it that way (since this function checks the ioctl value) and add a
pure 32-bit function for 32-bit enabled controllers ? I would say I have
no idea, it's clearly not my domain of expertise :-/

> Alan

Willy

