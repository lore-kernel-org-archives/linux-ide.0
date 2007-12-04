From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: Re: reset IOCTLs
Date: Tue, 4 Dec 2007 10:21:25 -0800 (PST)
Message-ID: <719908.73262.qm@web35414.mail.mud.yahoo.com>
References: <47553F3B.1090805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35414.mail.mud.yahoo.com ([66.163.179.123]:48056 "HELO
	web35414.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752371AbXLDSV0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 13:21:26 -0500
In-Reply-To: <47553F3B.1090805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


--- Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Kantor Zsolt wrote:
> 
> > Can somebody tell me what is the difference between these reset commands (I'm developing an
> open
> > source application and I would like to know this): one is in the cdrom.h (CDROMRESET -
> 0x5312),
> 
>     This one seems to be handled only by discrete (non-IDE) CD-ROM drivers.
> 
> > and the second with the third are in the hdreg.h (HDIO_DRIVE_RESET - 0x031c,
> 
>     This gets handled as the usual IDE reset, i.e. wia SRST bit of the device 
> control register.
> 
> > WIN_DEVICE_RESET - 0x08)
> 
>     This is not an ioctl() at all but ATAPI Device Reset command which can be 
> use dto reset ATAPI device insted of the usual IDE reset.
> 
> > Thanks
> >   Kantor
> 
> MBR, Sergei
> 

Thanks a lot ! I have one more question: I see that the HDIO_DRIVE_RESET - 0x031c is a soft reset,
but the WIN_DEVICE_RESET - 0x08 for ATAPI devices is a soft reset too ? and the first one for
non-IDE CD-ROMs is a hard reset ? because in the cdrom.h file states this: CDROMRESET 0x5312 /*
hard-reset the drive */

Cheers
  Kantor


      ____________________________________________________________________________________
Get easy, one-click access to your favorites. 
Make Yahoo! your homepage.
http://www.yahoo.com/r/hs 
