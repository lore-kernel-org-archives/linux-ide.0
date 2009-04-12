From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: refresh and convert to new EH
Date: Sun, 12 Apr 2009 06:46:33 +0400
Message-ID: <a4423d670904111946w2a8f3839n27b77f5473076563@mail.gmail.com>
References: <20090408200511.GA24071@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:42412 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZDLCqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 22:46:35 -0400
In-Reply-To: <20090408200511.GA24071@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

2009/4/9 Jeff Garzik <jeff@garzik.org>:
>
> I reviewed and refreshed libata-dev.git#new-eh, now renamed to #sx4.
>
> Several bugs and missing pieces in the new-EH conversion were address=
ed
> (often by copying highly similar code from sata_promise, a highly
> similar chip)
>
> The only thing left is some "it still works" testing... =C2=A0any tak=
ers?
>

Hi Jeff

I have SX4000 card, it is based on the same PDC20621 chip, but has PATA=
 ports
(without PATA-SATA bridges).
Can I help?

I am newbie here, but I will try to modify the driver to support PATA
card as well
and test your patch.
