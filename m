From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Thu, 17 Apr 2008 00:24:37 +0100
Message-ID: <20080417002437.559ec164@the-village.bc.nu>
References: <200804021524.27222.elendil@planet.nl>
	<20080415144748.GO7385@csclub.uwaterloo.ca>
	<48053AD1.8010007@gmail.com>
	<200804162008.27655.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755565AbYDPXvn@vger.kernel.org>
In-Reply-To: <200804162008.27655.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Tejun Heo <htejun@gmail.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org


> The problem here is determining whether a machine is "legacy" or not.
> So far in this discussion I've seen no suggestions how to do that (except 
> maybe for my test whether /sys/bus/isa is present), which would mean asking 
> _all_ users, and that's a damned ugly option.

Libata pata_legacy handles this itself for all known cases using the
ruleset

IF any PCI device -> no PATA legacy scans beyond IDE0/IDE1
IF any PCI IDE in legacy compat mode  -> No pata_legacy bind to that port
IF CS55x0 or MPIIX -> read the chipset magic [these are the obscure 'not
PCI but not ISA' specials]

Alan
