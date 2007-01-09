From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: SATA Promise
Date: Tue, 9 Jan 2007 10:58:19 +0100 (MET)
Message-ID: <200701090958.l099wJKA011667@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:61796 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbXAIJ6d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 04:58:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gary@mlbassoc.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 08 Jan 2007 10:06:49 -0700, Gary Thomas wrote:
> > Yes. SATAPI and PATAPI are working. Patches have been posted
> > to linux-ide, and hopefully final combined/reworked/tidied-up
> > patches should be available tomorrow.
> 
> Very nice, thanks.
> 
> BTW, what SATAPI drive did you try this with?  I have a Lite-On
> LTN-52S1S that doesn't seem to work at all with the PDC40775 - it
> just hangs during the bootup.

I tested SATAPI with a Samsung DVD-writer. I don't have
the exact model # handy, but the OEM appears to be Toshiba.
PATAPI was tested with a Phillips CD-writer.

/Mikael
