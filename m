From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch for 2.6.29? 4/4] pata_it821x: resume from hibernation
 fails with RAID volume
Date: Wed, 25 Feb 2009 15:29:04 -0500
Message-ID: <49A5AA10.5020800@garzik.org>
References: <200902112108.n1BL8hk7005336@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52636 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbZBYU3L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:29:11 -0500
In-Reply-To: <200902112108.n1BL8hk7005336@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, linux@rainbow-software.org, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Ondrej Zary <linux@rainbow-software.org>
> 
> Hibernation didn't work for me since I started to use IT8212 controller. 
> I did some debugging (booting with no_console_suspend init=/bin/sh).
> 
> Found that resume fails (2.6.28) with "serial number mismatch 'some
> garbage' != 'some other garbage'" and "revalidation failed" messages. 
> That's because the controller firmware fills different serial number in
> the IDENTIFY every boot.
> 
> The patch below fixes the resume simply clearing the serial number.  The
> proper fix would be probably to fill in the serial number of the RAID
> volume instead.  I assume that there must be something like that stored on
> the drives but I don't know where.
> 
> Fix resume on pata_it821x RAID volume by clearing the serial number in
> IDENTIFY data, which is otherwise different on each boot.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_it821x.c |    3 +++
>  1 file changed, 3 insertions(+)
> 

applied


