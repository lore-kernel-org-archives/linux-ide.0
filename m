From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: siimage card causes repeated oopses and panics on a PowerMac
 G4 running 2.6.12.1
Date: Mon, 27 Jun 2005 07:22:31 -0400
Message-ID: <42BFE177.1050007@pobox.com>
References: <9c1484f205062702203936d7ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15824 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261208AbVF0LWh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 07:22:37 -0400
In-Reply-To: <9c1484f205062702203936d7ca@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Schlansker <stevenschlansker@gmail.com>
Cc: linux-ide@vger.kernel.org

Steven Schlansker wrote:
> I have a SIIG Ultra-ATA 133/100 Pro for Mac card in my Sawtooth G4
> that, upon being touched in any way (loading the siimage module,
> trying to access the corresponding /dev/hd? entries, and just about
> anything else) causes either an oops, a flood of oopses, or a panic.

> If I do so much as touch the new /dev/hde entry or such, many more
> oopses and occassionally a panic will happen.  I can provide more
> samples if necessary, I figured two would be enough to get started. 
> The process is always different, and sometimes it even seems to be
> unrelated to the card entirely.  Usually it's modprobe and udev.  I
> have not successfully captured one of the panics with netconsole yet,
> but I remember the line "Aieeee, killing interrupt handler" from them.
>  I do not believe that the hardware is defective, as the exact same
> card works very well under Mac OS X (which even boots from a drive
> connected to it, so OpenFirmware does not seem to have issues with it
> either)

Two things:

1) turn off preempt

2) use sata_sil driver rather than siimage

	Jeff


