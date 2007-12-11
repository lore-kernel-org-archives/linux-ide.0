From: Mark Lord <liml@rtr.ca>
Subject: Re: Iomega ZIP-100 drive unsupported with jmicron JMB361 chip?
Date: Tue, 11 Dec 2007 11:57:07 -0500
Message-ID: <475EC163.8070305@rtr.ca>
References: <fa.yONLBG7CMuz80f4dUP5r/5k7emw@ifi.uio.no> <475DD7FF.4030906@shaw.ca> <475EAEDD.9090905@earthlink.net> <475EC0D1.8010200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754977AbXLKQ5V@vger.kernel.org>
In-Reply-To: <475EC0D1.8010200@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: trash can <thetrashcan@earthlink.net>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
>
> I missed the early part of this thread,
> but here is a data point that may or may not be useful.
> 
> I have an ASUS mobo here with an onboard JM363 SATA/PATA controller
> (verified by looking at the actual chip).
> 
> It works fine when in AHCI mode with a PATA ATAPI ZIP100 drive
> all by itself.  No other configurations tested.
> This is with kernel 2.6.24-rc4-git?.
..

Oh yeah.. that's with libata controlling all drives in the system.

This exact same mobo was used for a while with a PATA DVD-RW (no ZIP drive)
under older kernels using drivers/IDE, but was unreliable in that configuration
(Ubuntu Edgy).   Ditto when the PATA DVD-RW was replaced with a SATA DVD-RW.

-ml
