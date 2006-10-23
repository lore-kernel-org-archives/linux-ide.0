From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] ata: Generic platform_device libata driver, take 2.
Date: Mon, 23 Oct 2006 17:42:21 +0100
Message-ID: <20061023164220.GA24471@flint.arm.linux.org.uk>
References: <20061023065907.GA22029@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752005AbWJWQme@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061023065907.GA22029@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jgarzik@pobox.com>, Matthias Fuchs <matthias.fuchs@esd-electronics.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 23, 2006 at 03:59:07PM +0900, Paul Mundt wrote:
> This is the second attempt at a generic platform_device libata driver,
> attempting to take in to account issues raised by Matthias Fuchs and rmk.
> 
> Changes in this version include adding a small pata_platform.h header for
> the private data (which at the moment is limited to a register shift
> that's needed by ARM), though other things can be added in here if
> platforms start having other needs.

Thanks, this will enable me to use this code on ARM.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
