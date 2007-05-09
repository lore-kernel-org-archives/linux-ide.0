From: Dominik Schulz <lkml@ds.gauner.org>
Subject: Possible Bug in sata_via when trying to burn
Date: Wed, 09 May 2007 11:55:23 +0200
Message-ID: <46419A8B.2060605@ds.gauner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gauner.org ([85.10.240.115]:45556 "EHLO mail.gauner.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758063AbXEIKdt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 06:33:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi,
I'd like to report a possible bug in the sata_via module.

I - and at least one other user [1] - am not able to use a cd writer
attached to the VIA 6421 chip on Linux.

The current setup works perfectly on windows, so I think it's not a
hardware problem.

Until Kernel 2.6.21 I wasn't even able to use the PATA Port of the
mentioned controller. Now this works, but it would be great if one was
also able to use this controller to burn cds.

The Problem seems to affect cd writers attached to this chip, sata as
well as pata [2].

Some details of my system:
Debian etch, running the 2.6.21 Kernel.
The CD-Writer is a NEC ND-3500AG attachted to the PATA Port of the VIA
6421 Chip on an Abit AX8 V2.0 Motherboard.
lspci -vvv is at [3]
dmesg at [4]
the wodim output when trying to blank a cd [5]
kernel .config at [6]

[1] - http://www.mail-archive.com/cdwrite@other.debian.org/msg10988.html
[2] - http://www.mail-archive.com/cdwrite@other.debian.org/msg11017.html
[3] - http://blog.gauner.org/dl/lspci.txt
[4] - http://blog.gauner.org/dl/dmesg.txt
[5] - http://blog.gauner.org/dl/wodim.txt
[6] - http://blog.gauner.org/dl/config-2.6.21tex


