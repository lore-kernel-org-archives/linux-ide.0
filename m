From: Richard Aplin <drtune@gmail.com>
Subject: Re: Supporting SATA Target mode (or any data transfer w/crossover
 cable) on AHCI
Date: Sun, 27 Feb 2011 17:30:31 -0800
Message-ID: <AANLkTikSJc99fce5+Por2BRqLq1MhicH3LKQgVpUOixm@mail.gmail.com>
References: <AANLkTi=mPAjKk0kZTuP-3fyQB8Rm0=mo5GDx9BOC073S@mail.gmail.com>
	<4D6A5B72.6040600@teksavvy.com>
	<AANLkTikaYHLinw0KbGJ3Rzcg6AZ4VfeQLeHQDt9za5Fh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34153 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1B1Bac (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Feb 2011 20:30:32 -0500
Received: by iwn34 with SMTP id 34so2682509iwn.19
        for <linux-ide@vger.kernel.org>; Sun, 27 Feb 2011 17:30:32 -0800 (PST)
In-Reply-To: <AANLkTikaYHLinw0KbGJ3Rzcg6AZ4VfeQLeHQDt9za5Fh@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

BTW for those who missed it, there was another recent (may 2010)
thread on Marvell Target drivers
http://www.spinics.net/lists/linux-ide/msg37863.html

where Saeed Bishara posted mods to the GPL Marvell drivers (not
libata) for chips such as this...
http://www.marvell.com/products/processors/embedded/kirkwood/FS_88F6180_9x_6281_OpenSource.pdf
and added some form of C2C / Target support

I don't have such a controller but I'm going to see if I can find one
in an expresscard format, for testing purposes.

I'm still after AHCI support for popular mobo chips, but that may be a
pipe dream.

Frustratingly I have this suspicion that Target mode support on those
chips - if not already present - might be possible by updating these
chip's firmware. I am guessing this is in flash or bios-loaded SRAM
nowadays. I also guess this avenue will lead nowhere. ;-)

Cheers,
Rich.
