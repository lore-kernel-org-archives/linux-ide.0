From: "F. P. Beekhof" <fpbeekhof@gmail.com>
Subject: Machine check exception
Date: Wed, 27 Jul 2011 13:05:16 +0200
Message-ID: <4E2FF0EC.2020704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64598 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab1G0LFT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2011 07:05:19 -0400
Received: by wwe5 with SMTP id 5so1289967wwe.1
        for <linux-ide@vger.kernel.org>; Wed, 27 Jul 2011 04:05:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hello,

I'm having some trouble with my Promise TX4302: it seems to cause kernel 
panics due to machine check exceptions.

The MCE reads:
[Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 4: ...
[Hardware Error]: TSC 264f8ca046
and then continues about a NorthBridge Watchdog timeout.
After that, there is kernel stack dump:

See http://tech.unige.ch/mce.jpg or http://tech.unige.ch/mce.png for a 
screenshot.

These always happen when I'm accessing disks attached to the TX4302, as 
far as I can tell. Motherboard is an Asus a8v, cpu is amd athlon64, 
stock ubuntu 11.04 kernel.

I have no idea where to go from here though. I can provide any 
information required or test patches, please ask.

Best, and thanks in advance,

F. Beekhof
