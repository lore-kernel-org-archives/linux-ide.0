From: Matt Grice <mcjgrice@gmail.com>
Subject: libata errors
Date: Tue, 7 Apr 2009 21:40:21 +0100
Message-ID: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:37321 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761132AbZDGUkW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 16:40:22 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so2484201bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 13:40:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Dear Mr Garzik,

I am currently having trouble with the new libata kernel subsystem (My
system broke after 2.6.21 I believe). After much fruitless googling
and trawling through the libata code (I am *no* kernel programmer!) I
took the serious, final step of bugging you.

Ten or so minutes after boot (long enough for my two IDE Sony DW-G120A
DVD writers to spin down) I start getting these error messages in my
kernel logs:

[ 6317.817041] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 6317.817057] ata4.01: cmd a0/00:00:00:08:00/00:00:00:00:00/b0 tag 0
pio 16392 in
[ 6317.817058]          cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
[ 6317.817059]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)
[ 6317.817064] ata4.01: status: { DRDY }
[ 6317.817087] ata4: soft resetting link
[ 6318.221356] ata4.00: configured for PIO0
[ 6318.253533] ata4.01: configured for PIO0
[ 6318.253567] ata4: EH complete
[ 6335.817039] ata4.00: qc timeout (cmd 0xa0)
[ 6335.817059] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 6335.817069] ata4.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[ 6335.817070]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[ 6335.817071]          res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask
0x5 (timeout)

ad nauseam.

(I am running kernel 2.6.27-11, amd64. I have also tried 2.6.29, and
the messages are the same)

My DVD writers then cease to function.


My initial thoughts are that my spun-down devices are taking too long
to respond to requests from the kernel. I braced myself and then dived
in to the icy waters of the kernel sources to see if there was a
timeout I could increase. However, there are several structs with
timeouts in libata-eh.c, and the last thing my poor kernel needs is a
moron like myself twiddling random constants.

Could you please let me know if you think I am on the right track? Or
maybe suggest a timeout to twiddle?


Many thanks, and many apologies for interrupting you.


Kind Regards,


Matt Grice
