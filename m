From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Asus P5B-VM motherboard:  cd drive malfunctions if internal nic in use.
Date: Tue, 13 Mar 2007 11:32:52 -0400
Message-ID: <20070313153252.GC22466@csclub.uwaterloo.ca>
References: <200703122212.l2CMCaxm032601@osprey.cs.arizona.edu> <45F5D59E.10304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753281AbXCMPcy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45F5D59E.10304@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Phil Kaslo <phil@cs.arizona.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Mar 12, 2007 at 06:35:10PM -0400, Mark Lord wrote:
> Is that a PATA cd-drive?  If so, then you must have hooked it up
> to the JMicron IDE controller.  That driver is just plain buggy.
> 
> I gave up on it for my own P5B-VM.  The libata version works better
> than the drivers/ide, but I gave up on it and got a SATA DVD/RW drive.
> 
> Off topic:  do your USB ports power off when the system shuts down?
> Mine don't -- the +5V continues on them.. I'd love a tip on how to
> turn them off completely at shutdown.

Most Asus boards have jumpers for the USB ports to select between +5V
and +5VSB (stand by power).  The reason to provide standby power is so
that keyboards with power buttons can remain powered so that you can
turn the system on using the usb keyboard.  If you want to power off the
ports entirely, jumper them to the +5V line instead which only has power
when the system is on.

--
Len Sorensen
