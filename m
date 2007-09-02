From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 13:42:16 +0100
Message-ID: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:51100 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965316AbXIBMmS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 08:42:18 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1112846fkz
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 05:42:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello everyone,

In the hope of making myself a cheap SSD, I decided to replace my IDE
HDD on my IBM Thinkpad X41 (non tablet) with a generic CF-IDE adaptor,
and a Sandisk Extreme IV 4Gb CF, for reasonable prices off ebay. This
was partly influenced by the report that one X41 Tablet user had it
working successfully: http://forum.thinkpads.com/viewtopic.php?t=41568
(last post on that page)

As some of you may know, the X41 uses a SATA controller, which goes
into a SATA-PATA bridge, and then connects to a PATA HDD. This is a
strange setup, and may go some distance as to explaining why it
doesn't work.

The first I tried was the Ubuntu Feisty LiveCD, which uses 2.6.20, and
libata picks the drive up correctly. A hdparm -I showed that the
device was currently running at mdma2 - which was not what I expected
- the Sandisk, as garnered from review websites, supports UDMA. A
quick hdparm -t also revealed that I was only getting about 6MB/s.

Nonetheless, I tried to partition the disk - at which point mkfs.ext3
froze. Looking at dmesg, I saw some timeout commands, looking
something like:
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: soft resetting port
ata1: ... exception ... res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask
0x4 (timeout)

I have also tried the latest Gutsy LiveCD, using kernel 2.6.22, and
that exhibits the same problem too. Also, I've also tried booting the
LiveCD in expert mode, unloading the ata_generic, ata_piix and libata
drivers, and loading ide-generic - at which point my drive shows up as
/dev/hda rather than /dev/sda. However, the CF card is still
recognised as only supporting mdma2, and hdparm -X still does not
allow me to set the transfer mode to anything else (the command goes
through without any errors, but another -i shows that the mode is
still mdma2). However, using ide-generic allows me to access the drive
"succesfully" (no timeout errors), but at an even more measly 2MB/s.

These errors are very similar to those that this list has seen before:
ICH8 timeout regression: http://www.spinics.net/lists/linux-ide/msg13104.html
CF flash IDE failure to attach:
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg07402.html
CompactFlash performance (this guy gets 30MB/s using UDMA on an ICH8 -
I'm very jealous!)
http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/6818048.html
Another Sandisk CF user only seeing mdma too:
http://www.spinics.net/lists/linux-ide/msg00207.html

I have read through those threads, but I'm not sure how I can apply
what they've learnt to my situation, and this is where I would like to
ask all you experts out there for some help!

My thoughts are as follows;
- MDMA is not really supported, hence why it is so slow - if I can
disable mdma and tell it to use single word PIO4, then I might get a
reasonable 15Mb/s - however extensive searching has shown me that
libata doesn't allow a user to set the xfer mode?
- UDMA is not detected for some reason, even if it is supported by the
card and by the controller (is there any way to force that to be
enabled, regardless of whether it is detected or not?)
- Even more worryingly for me, is that Windows also resorts to using
Multiword DMA 2, and it is frightfully slow (which is a big
disappointment - seeing as another X41 user (who is undoubtedly using
windows!) has reported success!) - I am currently trying to get in
touch with this user
- I bought a card which is too fast for its own good - if only it
could only support PIO, then I might not be in this mess! =)

Has there been any fixes since 2.6.22 (such as those patches that have
been suggested/used in the previous discussions) which could possibly
solve my problem?

Sorry for the long e-mail, and any help would be very very gratefully
received and appreciated!

Thanks and best regards,

Eddie Hung
