From: Jeff Garzik <jgarzik@pobox.com>
Subject: ata_piix and combined mode
Date: Mon, 22 Mar 2004 13:06:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <405F2B2E.6080001@pobox.com>
References: <20040322132336.GA12460@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040322132336.GA12460@cistron.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org

Yeah, combined mode is not recommended.  The device presences for 
slave-only is a bit off, and also because it often massively impacts 
PATA speed and/or stability.

There are a few simple things you can do though, which would fix your 
problem.  Here is a summary, interested in working on it?  :)  (or 
anyone else listening)

struct ata_port::port_no is only accurate in native mode, where all PCI 
BAR resources and PCI irq are active.  combined mode is a subset of 
legacy mode, where
	a) port 0 and port 1 IO ports are standard IDE ISA register blks
	b) irqs are standard legacy 14 and 15, and not shared
	c) hardware pretends that SATA0/1 are master/slave.
	This last introduces nastiness into most drivers, since sata
	is _really_ point-to-point.  Faking non-PTP this way leads
	to a disconnect, because you must now map master to
	port 0 or 1, and slave to the other port (yes ordering
	is dynamic too).

1) short term, probably want to create a "hard_port_no" field in 
ata_port, and make that reflect the true SATA hardware port number. 
Then use that in the disable/enable stuff in ata_piix.c.

2) module unload disables the SATA port, but module load does not 
attempt to enable the SATA port.  so modprobe+rmmod+modprobe will 
results in sata ports being disabled.  instead, enable each sata port 
(which causes the right SATA phy stuff to happen silently), wait a bit, 
check for device presences, then disable the port if no device.

3) long term, since combined mode combines PATA and SATA into the same 
PCI device, under the SATA PCI id, libata can drive the PATA port as 
well.  libata must do this anyway, for Promise, where the PATA port is 
even more tightly integrated with the SATA ports.

The blocker on #3 is debugging the existing ATAPI code.  Once that's 
working, PATA support can be turned on -- for the cases that need it.  I 
still want 99% of PATA handled in drivers/ide...

Even longer term, we just need to beat hardware vendors over the head 
about combining PATA and SATA into the same PCI device.

	Jeff
