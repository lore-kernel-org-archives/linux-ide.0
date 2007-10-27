From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH-RFC] Promise SATA300 TX4
Date: Sat, 27 Oct 2007 19:32:25 +0400
Message-ID: <47235A09.7090409@lxnt.info>
References: <200710271453.l9RErRj9020770@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:65259 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbXJ0PmD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 11:42:03 -0400
In-Reply-To: <200710271453.l9RErRj9020770@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, jeff@garzik.org, jgarzik@pobox.com

Hello.

> Interesting, but can you please give more background information?
> I.e., how did you determine the existence of this bug?

I was experiencing read/write errors, with data corruption.
Dmesgs and lspcis are at http://lxnt.info/linux/

I downloaded driver from the promise.com, put up 2.6.11 and compiled it.
It worked ok.

I then unsuccessfully tried to port the driver to 2.6.22.
While I failed, this gave me enough insights into ATA workings, that I
could read the CAM module that comes with the driver.

Looking through it I found the SG_COUNT_ASIC_BUG constant and
corresponding code. I decided to try and implement the workaround in
sata_promise.c - and this fixed the problem.

> And please cc: the sata_promise maintainer on sata_promise patches.
> (Hint: that's me)

Hmm. sata_promise.c says:

*  Maintained by:  Jeff Garzik <jgarzik@pobox.com>

> Meanwhile I'll check the Promise driver(s) to see if there's
> something about SG table formatting restrictions there.

Take a look at:

cam_ata.c:6190
cam_ata.c:6259

The fix is also conditioned on sg segment length == 0, which I did not
implement. Is this at all possible in libata ?

-- 

./lxnt
