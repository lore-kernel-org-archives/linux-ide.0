From: Willy Tarreau <w@1wt.eu>
Subject: Re: Compact Flash performance...
Date: Sat, 2 Jun 2007 07:10:06 +0200
Message-ID: <20070602051005.GQ943@1wt.eu>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com> <465E3FF0.9010709@rtr.ca> <6278d2220705310222rde9ad28ndfd8feced84a3c6f@mail.gmail.com> <465EBE20.6090803@rtr.ca> <6278d2220705311025q6ee030e2kd44b7302a50ac902@mail.gmail.com> <465F360D.6020603@rtr.ca> <6278d2220705311439x40f7b1c1l7cef54acd2e8fcea@mail.gmail.com> <465F4D4E.6050305@rtr.ca> <465F4E20.5080503@garzik.org> <465F4FA2.8030200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756782AbXFBFKf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <465F4FA2.8030200@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Daniel J Blueman <daniel.blueman@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

On Thu, May 31, 2007 at 06:43:46PM -0400, Mark Lord wrote:
> Jeff Garzik wrote:
> >Mark Lord wrote:
> >>Some cards may perform better when their "memory" interface is used
> >>instead of the "I/O" interface, or vice-versa.  I'm not sure which
> >>of the two methods was selected by libata (probably the "memory" 
> >>interface).
> >
> >I am very CF-ignorant.  How does libata select a memory or I/O interface 
> >on a CF device?
> 
> Right.  Usually we cannot select them, as it's the wires between
> the ATA chipset (motherboard) and the CFCARD that determine this.

CF cards support 3 modes (MEM, I/O and True IDE), and neither MEM nor I/O
modes can talk IDE. Most often, the PIN 9 is simply shorted to the ground
at the connector to set the card in True IDE mode, which makes it emulate
a standard IDE disk.

Cheers,
Willy
