From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add Marvell 6141 PATA support to AHCI driver
Date: Sun, 27 May 2007 13:18:07 +0100
Message-ID: <20070527131807.46b81b8d@the-village.bc.nu>
References: <20070527030954.GA18974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754444AbXE0MNZ@vger.kernel.org>
In-Reply-To: <20070527030954.GA18974@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> Engineering questions I need to bounce back to Marvell:
> * do I need to worry about PIO/UDMA timing?  I don't see any registers
>   or other knobs dealing with timing.  Maybe the controller snoops?

In non-AHCI mode it certainly seems to do the snooping for you

Acked-by: Alan Cox <alan@redhat.com>

Alan
