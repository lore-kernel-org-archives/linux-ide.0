From: David Shaw <dshaw@jabberwocky.com>
Subject: Suppressing ATA errors on boot
Date: Wed, 29 Jun 2011 11:07:11 -0400
Message-ID: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from walrus.jabberwocky.com ([173.9.29.57]:48623 "EHLO
	walrus.jabberwocky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab1F2PUe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2011 11:20:34 -0400
Received: from dshaw.nasuni.net (vpn.nasuni.com [173.166.63.186])
	(authenticated bits=0)
	by walrus.jabberwocky.com (8.14.4/8.14.4) with ESMTP id p5TF7BOE017238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 29 Jun 2011 11:07:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm using kernel 2.6.35.13-91 (it's Fedora 14) on a Dell R410 server.  On each boot, I see a few messages like:

ata2.00: failed to resume link (SControl 0)
ata4: failed to resume link (SControl 0)
ata4: SATA link down (SStatus 4 SControl 0)
ata1.01: failed to resume link (SControl 0)

These messages happen right before the splash screen (Plymouth) comes up and so are visible to users during the boot.  It seems to be harmless, as there is only one SATA device plugged in (a DVD reader), and it's on ata3.  There is nothing on the other ata ports, and they are set to "off" in the BIOS in any event.

I've been asked to look for a way to avoid those messages on boot as some users might become concerned and think there is a problem when there isn't.  

Is there some way to tell libata that those ports shouldn't even be probed?  Alternately, is there a way to selectively prevent those messages from being logged (without affecting the logging for the rest of the boot)?  Or perhaps a third solution?

Thanks very much!

David

