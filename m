From: Mark Lord <liml@rtr.ca>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 13:19:03 -0400
Message-ID: <46265307.7060405@rtr.ca>
References: <88SeR-5Sf-15@gated-at.bofh.it>	<88Sov-662-3@gated-at.bofh.it>	<88SHV-6uL-29@gated-at.bofh.it>	<8agVk-3wc-81@gated-at.bofh.it>	<8b3IR-4mE-25@gated-at.bofh.it>	<8b3SA-4z3-5@gated-at.bofh.it>	<8b42g-51N-15@gated-at.bofh.it>	<8bbdm-7iS-27@gated-at.bofh.it>	<E1He8dA-0000mw-LI@be1.lrz>	<46260981.1040109@gmail.com>	<20070418132904.3322ba5f@the-village.bc.nu>	<46261337.3010406@gmail.com>	<20070418140346.636879a1@the-village.bc.nu>	<46262C0E.9000103@rtr.ca> <20070418160627.7ab77c30@the-village.bc.nu> <46263650.3080705@rtr.ca> <46263859.2060309@gmail.com> <46265089.4000409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1573 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992896AbXDRRTE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Apr 2007 13:19:04 -0400
In-Reply-To: <46265089.4000409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

Mark Lord wrote:
> 
> With the patch applied, I don't see *any* new activity in those S.M.A.R.T.
> attributes over multiple hibernates (Linux "suspend-to-disk").

Scratch that -- operator failure.  ;)
The patch makes no difference over hibernates in the SMART logs.

It's still logging extra Power-Off_Retract_Count pegs,
which it DID NOT USED TO DO not so long ago.

Now I'll poke at the shutdown again.

Meanwhile, Stephen:  Could you try without this line in the patched file:

        case ATA_16:
+               dev->needs_sync_cache = 1;

Ie. comment out that last "dev->needs_sync_cache" line.

Cheers
