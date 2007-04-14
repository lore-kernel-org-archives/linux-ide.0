From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sat, 14 Apr 2007 11:27:46 +0200 (MEST)
Message-ID: <200704140927.l3E9RkXu023370@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:34942 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbXDNJ1w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Apr 2007 05:27:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi.Orava@ncircle.nullnet.fi
Cc: linux-ide@vger.kernel.org

On Sat, 14 Apr 2007 10:13:12 +0300 (EEST), Tomi Orava wrote:
>I'm currently running with FC6 2990 kernel, which is based on
>2.6.21-rc3-git10 and contains also your 1.5Gbps limit patch and Promise
>Sata300TX4 port enumeration patch (does anybody know what might be the
>reason that port enumeration patch has not been accepted in to main line
>?).

Because that patch hasn't been submitted to linux-ide,
Jeff, or me?

I've seen fairly old discussions about the enumeration
order issue on 4-port cards, but no patches.

/Mikael
