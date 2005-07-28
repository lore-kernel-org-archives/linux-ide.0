From: "Allen Bolderoff" <allen@gist.net.au>
Subject: More Promise PDC Probs with sata_promise
Date: Thu, 28 Jul 2005 09:55:15 +0930
Message-ID: <EC70EFBFB6977A478BEB386684E8A742AE70@pwfsbs01.pwf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gist.net.au ([203.20.102.8]:64166 "EHLO mail.gist.net.au")
	by vger.kernel.org with ESMTP id S261306AbVG1A02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jul 2005 20:26:28 -0400
Received: from localhost (mail [127.0.0.1])
	by mail.gist.net.au (Postfix) with ESMTP id 6ED797B4F6
	for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2005 09:56:46 +0930 (CST)
Received: from mail.gist.net.au ([127.0.0.1])
	by localhost (mail.gist.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27627-05-3 for <linux-ide@vger.kernel.org>;
	Thu, 28 Jul 2005 09:56:46 +0930 (CST)
Received: from wespac.com.au (unknown [202.174.41.114])
	by mail.gist.net.au (Postfix) with ESMTP id F04317B501
	for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2005 09:56:45 +0930 (CST)
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I too am having problems with the sata_promise driver in 2.6.12 with a =
Sata II TX4, and a SATA  on an intel SE7520BD2 board

=46irst some Idea of what we are running -=20

	Pristine Debian Sarge install

	Stock Kernel 2.6.12.3 (with no extra patches)=20

	Using the config from the 2.6.8-2-686-smp kernel supplied on debian, 	=
(ie make oldconfig)

Also, I am getting the same problems with a 2.6.10 kernel
=20

Relevant Lines from lspci

=20

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 S=
torage Controller (rev 02)                         =DF ONBOARD 2 Port S=
ATA CONTROLLER

0000:02:03.0 RAID bus controller: Promise Technology, Inc. PDC20319 (Fa=
stTrak S150 TX4) (rev 02)                    =DF Promise S150 TX4 (raid=
 controller used as straight SATA controller)

0000:07:06.0 Unknown mass storage controller: Promise Technology, Inc.:=
 Unknown device 3d18 (rev 02)             =DF Promise SATAII150 TX4 (st=
raight SATA controller)

=20

What is happening is that when we use just the 1st and 3rd SATA control=
lers, with Kernel 2.6.12.3, utilising debian sarge and LVM2, we have NO=
 problem.

=20

However, when we add a PDC20319 (2nd listed controller from lspci outpu=
t), we start to see some problems as follows

=20

We started out with the following Errors whilst trying to mke2fs -j on =
an LVM volume that spanned 3 drives on the PDC20319

=20

        Uhhuh. NMI recieved for unknown reason 31 on CPU0.
        Dazed and confused, but trying to continue
        Do you have a strange power saving mode enabled?
=20

So, now in investigating this problem, we found nothing of interest as =
the kernel was not generating any other messages - it would just repeat=
 that error 3 times, wait about 15seconds and reboot.

=20

On a whim, I disabled NMI watchdog with append=3D"nmi_watchdog=3D0", an=
d now started to receive slightly more verbose error messages:

=20

            ata3 command timeout (sometimes it would give ata4 erros in=
stead)

            Machine Check Exception 0x4 (or something similar)

=20

In investigating this error, we found the following link which would ap=
pear to be the exact problem

=20

http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/1671725=
=2Ehtml

=20

Is there anyone that might be investigating this problem that might be =
able use this (and any more they need) information to maybe solve the i=
ssue?

=20

I don't think the SATAII150 card is the problem, as it works fine in al=
l instances - the S150 TX4 works fine on Windows (I know, I know not a =
windows forum) with all drives set in the same mode (each as an individ=
ual stripe)

=20

In fact, if I plug the drives from the SATAII150 into the S150 TX4, the=
 previously working drives exhibit the same problem., and the reverse i=
s true, if I move the drives to the SATAII150, they work fine.

=20

TIA

=20

=20

Allen Bolderoff
