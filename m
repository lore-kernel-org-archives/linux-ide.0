From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Question about LS120 floppies
Date: Sun, 02 Aug 2009 18:19:09 -0500
Message-ID: <4A761EED.4030606@lwfinger.net>
References: <4A4BC762.3090104@lwfinger.net>	<4A4C441B.6050808@gmail.com>	<4A4CBD9E.4070404@lwfinger.net> <20090702181240.747e4063@lxorguk.ukuu.org.uk> <4A4D48A6.2060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:51149 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZHBXZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2009 19:25:41 -0400
Received: by pzk38 with SMTP id 38so1896270pzk.33
        for <linux-ide@vger.kernel.org>; Sun, 02 Aug 2009 16:25:41 -0700 (PDT)
In-Reply-To: <4A4D48A6.2060204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Roland Hughes <roland@logikalsolutions.com>

Robert Hancock wrote:
> Yes, definitely a lot of uninformed speculation on that thread. The
> floppy driver has nothing to do with any IDE/ATA drive like this, and if
> OpenSUSE is using libata drivers then attempting to load the IDE floppy
> driver is also useless.
> 
> It would be useful if the reporter could verify that the drive is at all
> functional with that media under any OS. That "Cannot read medium -
> unknown format" is being reported by the drive itself in response to a
> "read capacity" request, not the driver. So unless there's some magic
> that the driver needs to do to get the drive to recognize the disc, it
> seems like a hardware problem.

Since the last posting on this thread, I have acquired the hardware
from Roland Hughes. He reports that it worked with Ubuntu Hardy,
FreeDOS and Windows XP. I am assuming that the hardware is OK, but it
certainly is strange. I don't know the details for all commands, but
the command to get the capacity is 0x23 rather than the standard 0x25.

Will it be possible to make such strange hardware work under libata?
Is there a document that shows how to implement quirky devices? I
found the scsi_static_device_list[] entries, but also saw the
admonition not to add to that list.

Thanks,

Larry



