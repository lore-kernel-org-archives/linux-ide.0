From: Paolo Minazzi <paolo.minazzi@gmail.com>
Subject: problem on harddisk
Date: Wed, 5 Sep 2012 09:48:04 +0200
Message-ID: <CABmfJQYyYaZF0KQ4ZJt0Q8i95uZKvjsWR2ogwZfkrMstbpe-8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57327 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2IEHsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2012 03:48:05 -0400
Received: by weyx8 with SMTP id x8so186364wey.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2012 00:48:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,
I have a desktop PC with a SATA harddisk and a slackware 13.1 x86_64.

In the last days I have seen a lot of problem on my console.
Now I don't have the exact messages, but I saw

ACC=0x11, ASCQ=0x05
......
....please be patiente
reset ...

I think it is not related to a bad hardware.
I have tried an harddisk check program under DOS and it seems OK.
On windows I don't have problems, or maybe there are no messages visible.

I have tried the last kernel but I think I see more messages of errors.
It seems better with older kernel, for exampel 2.6.21, the one with
slackware 12.

I have tried to enable only the old IDE subsystem, but my controller
is not supported.
I need the new SATA subsystem.

This is my controller:
{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata },

Can you give me an advice ?
I can give you all details you want.

Thanks for your time
Paolo Minazzi
