From: Dominic Ijichi <dom@ijichi.org>
Subject: sata suspend status?
Date: Sat, 26 Nov 2005 15:56:22 +0000
Message-ID: <1133020582.438885a6615dc@www.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buffy.ijichi.org ([213.161.76.94]:19706 "EHLO buffy.ijichi.org")
	by vger.kernel.org with ESMTP id S964799AbVKZP42 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2005 10:56:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by buffy.ijichi.org (Postfix) with ESMTP id B8ADC183E7
	for <linux-ide@vger.kernel.org>; Sat, 26 Nov 2005 15:56:26 +0000 (GMT)
Received: from buffy.ijichi.org ([127.0.0.1])
 by localhost (buffy.ijichi.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 04079-05 for <linux-ide@vger.kernel.org>;
 Sat, 26 Nov 2005 15:56:22 +0000 (GMT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hello

i've been trying to get my laptop s3 suspend working - its all working except I
believe for sata.  it resumes and you can do type in, interact with the kernel
but as soon as you do anything that requires disk access it hangs. sorry if this
isn't very technical description, i can provide anything if told roughly what to do!

i've searched extensively for patches, tried all the various incantations, and
currently running 2.6.15-rc2 which is supposed to provide support for ata
passthrough and basic scsi suspend, but still same problem. i have:

Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04)

/dev/sda = HITACHI_DK23FA-60

hdparm -I /dev/sda works fine.

I note recent patches from randy dunlap from intel to do with this controller
and acpi but not sure what kernel this is against or whether it's relevent.

i believe there are many people out there who would love to get sata
suspend/resume working, its a major problem for all recent laptops and us folks
who love running linux.  what's the current status please?

thanks
dom

------------------------------------------
This message was penned by the hand of Dom
