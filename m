From: Marc Singer <elf@buici.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 5 Jun 2004 12:49:59 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040605194959.GA13228@buici.com>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:24471 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261865AbUFETuB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 15:50:01 -0400
Content-Disposition: inline
In-Reply-To: <200405151923.50343.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> - IDE is going into full host driver model
>   so write host driver for your interface

Can you tell me what this means?  Is arm/rapide.c an example?  If not,
what *is* and example?  Is the arm/ide_arm.c *not* the right way?

> - see drivers in drivers/ide/arm and drivers/ide/legacy for examples
>   (especially m68k and arm specific drivers)
> 
> - do not use ide_setup_ports()

Hmm.  macide in legacy does.  Is this, then, a bad bad example legacy?

The piece I'm missing is how to replace the ioops functions for my
platform.  I could implement something in ide-iops.c.  Is that the way?


