From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Sun, 13 Jul 2008 15:08:00 +0100
Message-ID: <20080713150800.664ef076@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<200807131347.14045.linux@rainbow-software.org>
	<20080713123510.6f47ffdc@lxorguk.ukuu.org.uk>
	<200807131410.16521.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56610 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753454AbYGMOZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jul 2008 10:25:48 -0400
In-Reply-To: <200807131410.16521.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, 13 Jul 2008 14:10:14 +0200
Ondrej Zary <linux@rainbow-software.org> wrote:

> On Sunday 13 July 2008 13:35:10 Alan Cox wrote:
> > > The patch below fixes the IDENTIFY problem for me and makes the RAID
> > > array accessible. Is it OK or is there a better way to do it?
> >
> > Probably better to fix it in driver. Right now we don't have a way to
> > override the identify reading or post process it cleanly at it821x hacks
> > around that but if that was fixed then the special cases can all hide in
> > the driver where they belong.
> 
> That would be great but it requires some deeper libata and kernel programming 
> knowledge.

Not a lot I think so I've added it to my todo list if nobody else does it.
