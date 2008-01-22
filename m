From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SiI 3512 Serial ATA Controller - kernel 2.6.23
Date: Tue, 22 Jan 2008 16:05:43 -0500
Message-ID: <47965AA7.4080703@garzik.org>
References: <Pine.LNX.4.63.0801222230470.4758@crystal.rdstm.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59674 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbYAVVFp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 16:05:45 -0500
In-Reply-To: <Pine.LNX.4.63.0801222230470.4758@crystal.rdstm.ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Nica <timi@crystal.rdstm.ro>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Dan Nica wrote:
> hello
> 
> I have a problem with a serial ata controller
> that uses a SiI 3512 chip.

A complete dmesg, complete lspci would be helpful.


> when I'm trying to add a device thats on the 3512 controller 
> to the array that I have, it give me lots of errors in dmesg
> like this:
> 
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x2400000 action 0x0
> ata3.00: BMDMA2 stat 0x8652001
> ata3.00: cmd 35/00:80:3f:5c:03/00:02:00:00:00/e0 tag 0 cdb 0x0 data 327680 
> out
>          res 51/04:80:3f:5e:03/00:00:00:00:00/e0 Emask 0x1 (device error)

That's the device reporting an error, when the system issued a WRITE 
command ("cmd 35/....."), and the SiI controller is happily reporting 
that error to you.

I would worry about the device, if it is reporting errors on WRITE.

	Jeff



