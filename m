From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 19 Jan 2009 12:20:24 +0100
Message-ID: <200901191220.24410.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901161843.19487.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:28704 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbZASLN5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 06:13:57 -0500
In-Reply-To: <200901161843.19487.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

On Friday 16 January 2009 18:43, Bartlomiej Zolnierkiewicz wrote:
> > +#if 0
> > +	/* In 12-0275-01 version of the PCB address
> > +	 * lines CF_A0 and CF_A2 are swapped */
> > +	hw.io_ports.data_addr =	tf_base + 0;
> > +	hw.io_ports.error_addr = tf_base + 4;
> > +	hw.io_ports.nsect_addr = tf_base + 2;
> > +	hw.io_ports.lbal_addr = tf_base + 6;
> > +	hw.io_ports.lbam_addr = tf_base + 1;
> > +	hw.io_ports.lbah_addr = tf_base + 5;
> > +	hw.io_ports.device_addr = tf_base + 3;
> > +	hw.io_ports.command_addr = tf_base + 7;
> > +#else
> > +	/* Proper lines addresses */
> > +	hw.io_ports.data_addr = tf_base + 0;
> > +	hw.io_ports.error_addr = tf_base + 1;
> > +	hw.io_ports.nsect_addr = tf_base + 2;
> > +	hw.io_ports.lbal_addr = tf_base + 3;
> > +	hw.io_ports.lbam_addr = tf_base + 4;
> > +	hw.io_ports.lbah_addr =	tf_base + 5;
> > +	hw.io_ports.device_addr = tf_base + 6;
> > +	hw.io_ports.command_addr = tf_base + 7;
> > +#endif
>
> How's about using enums for offsets, i.e.
>
> enum {
> #if 0
> ...
> 	AT91_IDE_ERROR_ADDR_OFFSET = 4,
> ...
> #else
> ...
> 	AT91_IDE_ERROR_ADDR_OFFSET = 1,
> ...
> #endif
> };
Oh, I remove this code. It is just workaround for stupid
hardware bug.
 
