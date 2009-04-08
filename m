From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata errors
Date: Tue, 07 Apr 2009 20:06:57 -0600
Message-ID: <49DC06C1.9040700@gmail.com>
References: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55107 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZDHCHG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 22:07:06 -0400
Received: by fxm2 with SMTP id 2so2587293fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 19:07:03 -0700 (PDT)
In-Reply-To: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Grice <mcjgrice@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Matt Grice wrote:
> Dear Mr Garzik,
> 
> I am currently having trouble with the new libata kernel subsystem (My
> system broke after 2.6.21 I believe). After much fruitless googling
> and trawling through the libata code (I am *no* kernel programmer!) I
> took the serious, final step of bugging you.
> 
> Ten or so minutes after boot (long enough for my two IDE Sony DW-G120A
> DVD writers to spin down) I start getting these error messages in my
> kernel logs:
> 
> [ 6317.817041] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [ 6317.817057] ata4.01: cmd a0/00:00:00:08:00/00:00:00:00:00/b0 tag 0
> pio 16392 in
> [ 6317.817058]          cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
> [ 6317.817059]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x4 (timeout)
> [ 6317.817064] ata4.01: status: { DRDY }
> [ 6317.817087] ata4: soft resetting link
> [ 6318.221356] ata4.00: configured for PIO0
> [ 6318.253533] ata4.01: configured for PIO0
> [ 6318.253567] ata4: EH complete
> [ 6335.817039] ata4.00: qc timeout (cmd 0xa0)
> [ 6335.817059] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [ 6335.817069] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> [ 6335.817070]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> [ 6335.817071]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
> 0x5 (timeout)
> 
> ad nauseam.
> 
> (I am running kernel 2.6.27-11, amd64. I have also tried 2.6.29, and
> the messages are the same)
> 
> My DVD writers then cease to function.
> 
> 
> My initial thoughts are that my spun-down devices are taking too long
> to respond to requests from the kernel. I braced myself and then dived
> in to the icy waters of the kernel sources to see if there was a
> timeout I could increase. However, there are several structs with
> timeouts in libata-eh.c, and the last thing my poor kernel needs is a
> moron like myself twiddling random constants.
> 
> Could you please let me know if you think I am on the right track? Or
> maybe suggest a timeout to twiddle?

ATA command timeouts are usually pretty long (like 30 seconds) so 
usually if they time out something is wrong, or the drive has really 
gone into the weeds.

It looks like your drives are running at PIO mode 0 after the fault 
happens. What are they running at before? Full dmesg output from bootup 
might be useful..

> 
> 
> Many thanks, and many apologies for interrupting you.
> 
> 
> Kind Regards,
> 
> 
> Matt Grice
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

