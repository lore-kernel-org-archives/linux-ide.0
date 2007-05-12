From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: which version/patch to test?
Date: Sat, 12 May 2007 17:04:56 +0200 (MEST)
Message-ID: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64986 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667AbXELPFA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 May 2007 11:05:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@how.dk, linux-ide@vger.kernel.org

On Thu, 10 May 2007 21:41:32 +0200, Peter Favrholdt wrote:
>I would like to help by testing the most recent version of the 
>sata_promise driver on my
>
>Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
>
>with 4 Seagate 500GB ES drives:
>         Model Number:       ST3500630NS
>         Firmware Revision:  3.AEE
>         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
>
>This setup experienced a problem a while ago which was fixed using 
>2.6.21-rc2 + Mikael Petterssons "force 1.5Gbps patch".
>
>Could someone provide a hint on what sources/patches I should get?
>
>E.g. vanilla 2.6.21.1 + ?

For a SATA 300 TX4 you should test version 2.07 of sata_promise.c.
You can get it in 2.6.21-git16, or 2.6.21-mm2 plus the following
two patches:

http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-error_intr-abort_port-2.6.21-mm2
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-sataii-tx4-port-numbering-fix-2.6.21-mm2

or 2.6.21 plus the following three patches:

http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-3-sataii-tx4-port-numbering-fix-2.6.21

Note that this corrects the longstanding mis-enumeration
of ports on SATAII TX4 cards, so you may need to adjust
your /etc/fstab and boot-time root= parameter if you're
using hard-coded partition names.

/Mikael
