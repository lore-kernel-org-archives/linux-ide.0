From: Matthieu Helder <matthieu.helder@gmail.com>
Subject: re: Initio 1623 driver question
Date: Tue, 19 Aug 2008 20:22:12 +0200
Message-ID: <48AB0F54.5080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:60507 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYHSSYd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 14:24:33 -0400
Received: by ik-out-1112.google.com with SMTP id c28so65253ika.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 11:24:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: teheo@novell.com
Cc: linux-ide@vger.kernel.org

I've compiled and installed the 2.6.26.2 kernel.

Best regards,
Matthieu


Matthieu Helder wrote:
 > Dear Tejun,
 >
 >
 > I've experiencing a problem for which I searched many forums, but to no
 > avail yet, so I decided to ask you.
 > I'm trying to install two Western Digital sata disks (750 GB each) with
 > a PCI sata-controller that uses the Initio 1623 chipset. Operating
 > system is SuSe 11.
 > The PC is an Compaq deskpro something with a Celeron and 512 MB of ram.
 > It boots from a 10 GB ata disk.
 >
 > The problem is that the controller card seems to be recognized
 > correctly, the kernel module gets loaded and all, but the two disks are
 > not detected: sata link down.
 > I'm using your sata_inic162x driver module, the version that contains
 > lba48 support.
 > Do you have any idea what can be the case? At least I have the
 > impression that the BIOS doesn't support lba48, could that be it? Below
 > you'll find the output of some (hopefully relevant) commands.

Can you please cc linux-ide@vger.kernel.org 
<mailto:linux-ide@vger.kernel.org>?  And can you try to roll
your own kernel 2.6.26.2 <http://2.6.26.2> for the system so that we can 
try patches?
Maybe the reset timing is too aggressive.

Thanks.
