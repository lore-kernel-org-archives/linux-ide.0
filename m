From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Thu, 10 May 2007 15:00:26 +0200
Message-ID: <4643176A.80809@gmail.com>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com> <464206DB.1010506@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080702080700060100010906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:17944 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbXEJNAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 09:00:40 -0400
Received: by py-out-1112.google.com with SMTP id a29so463958pyi
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2007 06:00:39 -0700 (PDT)
In-Reply-To: <464206DB.1010506@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

This is a multi-part message in MIME format.
--------------080702080700060100010906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Harald Dunkel wrote:
> Hi Tejun,
> 
> Sorry to say, but after applying your patch it still doesn't work.
> 
> If I insert the DVD and wait before running xine, then I can watch
> it. But if I keep the tray open and run xine, then xine closes
> the tray. It gets stuck for some time, and then I get
> 
> % xine dvd:/dev/scd0
> This is xine (X11 gui) - a free video player v0.99.5cvs.
> (c) 2000-2006 The xine Team.
> libdvdread: Using libdvdcss version 1.2.9 for DVD access
> libdvdread: Could not open /dev/scd0 with libdvdcss.
> libdvdread: Can't open /dev/scd0 for reading
> 
> 
> kern.log says:
[--snip--]
> May  9 19:13:04 pluto kernel: ata2.00: configured for UDMA/33
> May  9 19:13:04 pluto kernel: ata2: EH complete

The patch wasn't trying to fix the original problem.  All it does it
making sure the device itself doesn't get disabled after such an event -
/dev/sr0 should be accessible even after garbled IDENTIFY.  Can you try
to trigger the condition where the device reports garbled IDENTIFY data
and says...

ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)

Without the patch, the device will be offlined so you can't use it
anymore unless you issue manual rescan or unplug and replug the device.
 With the patch, you should be able to access the device after EH is
complete.

> After that (the DVD is still in) I can rerun xine, and it works.
> This is reproducible using CSS DVDs. Using a DVD without CSS there
> is no such problem. It takes some time till the DVD is played,
> but there is no soft reset.
> 
> Using "gmplayer dvd://" I get the same problem.
>
> You told me some time ago that you bought the same drive. Can you
> reproduce this problem? Please don't get me wrong, I am glad to
> support you by trying out new patches.

I'd love to but I'm half globe away from my toys at the moment and not
going back till the end of this month, so....  If this isn't resolved
till I get back, I'll test myself.

It still could be that the dvd reading commands are issued with too
short timeout.  Does applying the attached patch make any difference?

-- 
tejun

--------------080702080700060100010906
Content-Type: text/x-patch;
 name="lengthen-cdrom-timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lengthen-cdrom-timeout.patch"

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 3625a05..e404464 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -341,7 +341,7 @@ static const char *mrw_address_space[] =
  * Another popular OS uses 7 seconds as the hard timeout for default
  * commands, so it is a good choice for us as well.
  */
-#define CDROM_DEF_TIMEOUT	(7 * HZ)
+#define CDROM_DEF_TIMEOUT	(15 * HZ)
 
 /* Not-exported routines. */
 static int open_for_data(struct cdrom_device_info * cdi);

--------------080702080700060100010906--
