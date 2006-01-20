From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Fri, 20 Jan 2006 16:11:20 +0100
Message-ID: <43D0FD98.4080406@keyaccess.nl>
References: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org> <200601201227.27000.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:35233 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751041AbWATPJv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jan 2006 10:09:51 -0500
In-Reply-To: <200601201227.27000.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

Helmut Toplitzer wrote:

> Rene: Could you please try this out?

Yes, but please note I don't have a VIA southbridge (an AMD756), only 
the VIA VT6212L EHCI controller. I commented the

#if defined(CONFIG_BLK_DEV_VIA82CXXX)

bit.

> I'm currently working with it and it looks good.
> Transfer rate is at 57MB and cooler goes down after
> booting.

Unfortunately, this all does absolutely nothing for me:

$ dmesg | grep VIA
DISABLE VIA HLT  activated

				hdparm -t /dev/hda = 50 MB/s
1. modprobe ehci-hcd		hdparm -t /dev/hda = 50 MB/s
2. switch on USB2 drive		hdparm -t /dev/hda = 42 MB/s
3. switch off USB2 drive	hdparm -t /dev/hda = 42 MB/s
4. modprobe -r ehci-hcd		hdparm -t /dev/hda = 50 MB/s

Ie, same as before. Also tried the "setpci" statements for AMD751 (and 
athcool) as described on the link you posted:

http://www.daniel.nofftz.net/linux/Athlon-Powersaving-HOWTO.html

My machine boots up with the powersaving feauture already disabled. When 
I enable it, I

a) hear my PSU calming down, confirming that it works
b) see the (non-ehci loaded) hdparm result drop from 50 to 45
c) lose at least my NIC, a few times all of the computer

That is, the system becomes very unstable. In any case, there is no 
effect on the ehci-hcd/vt6216l issue either. If I load ehci-hcd and 
switch on the USB2 drive when the powersaving is disabled, then I

a) hear the PSU going full speed again, confirming that something's
    being very busy there
b) see the hdparm result drop to the exact same 42MB/s
c) am lucky to have a non-frozen computer at this point

The c) is just the instability. The point is -- no effecf on this issue 
at all.

I believe we can conclude that it's confirmed that you and I weren't 
experiencing the same problem after all. I feel so alone again...

I do find it interesting that I hear the PSU foing to full again on 
switching on the external drive if I had lowered it by disabling the 
powersaving. This would seem to prove that, indeed, something is being 
_very_ busy there. Earlier, I have confirmed that there's really no 
driver -> controller communication going on at this point (and no 
interrupts controller -> driver) though.

Yes, I dislike VIA, and I'm probably just paranoid, but I so much would 
put it _not_ past those <censored> to do whatever they do on purpose, so 
that the chip's faster to the bus when it _does_ actually have something 
to do.

Many thanks for the ideas, but I'm still out of luck, it seems.

Rene.
