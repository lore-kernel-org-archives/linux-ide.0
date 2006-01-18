From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Wed, 18 Jan 2006 07:54:44 -0800
Message-ID: <200601180754.44944.david-b@pacbell.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <58cb370e0601180227q4807c531pc2319ff569d9e449@mail.gmail.com> <200601181536.16868.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:41903 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030361AbWARPyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jan 2006 10:54:45 -0500
In-Reply-To: <200601181536.16868.pvrusb2@toplitzer.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-usb-devel@lists.sourceforge.net
Cc: Helmut Toplitzer <pvrusb2@toplitzer.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> both kernels (with/out acpi):
>    Parameter              NO EHCI     USED EHCI
>    irqpoll                52MB/s       30MB/s
>    idle=poll              58MB/s       58MB/s

Well now that's progress.  Can someone explain what's happening?

> (BTW: Is it normal that you see
> 
>     Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>     Memory: 256468k/262080k available (1583k kernel code, 5060k reserved, 667k     
>     data, 136k init, 0k highmem)
> 
> when you close your eyes?)

:)
