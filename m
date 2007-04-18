From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 13:29:04 +0100
Message-ID: <20070418132904.3322ba5f@the-village.bc.nu>
References: <88SeR-5Sf-15@gated-at.bofh.it>
	<88Sov-662-3@gated-at.bofh.it>
	<88SHV-6uL-29@gated-at.bofh.it>
	<8agVk-3wc-81@gated-at.bofh.it>
	<8b3IR-4mE-25@gated-at.bofh.it>
	<8b3SA-4z3-5@gated-at.bofh.it>
	<8b42g-51N-15@gated-at.bofh.it>
	<8bbdm-7iS-27@gated-at.bofh.it>
	<E1He8dA-0000mw-LI@be1.lrz>
	<46260981.1040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44025 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752490AbXDRM26 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 08:28:58 -0400
In-Reply-To: <46260981.1040109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: 7eggert@gmx.de, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>

> Not that simple.  Most disks don't spin up on SYNCHRONIZE_CACHE if its 
> cache is clean.  Sadly some disks actually spin up when it receives spin 
> down command while spun down to immediately spin down again, so we would 
> be fixing problem for some number of disks while breaking others.  :-(

Snoop the last command sent to the drive, that tells you if you can skip
the cache flush ?
