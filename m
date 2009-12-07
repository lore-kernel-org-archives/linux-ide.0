From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [git patches] libata updates for 2.6.33
Date: Mon, 07 Dec 2009 16:28:25 +0300
Message-ID: <4B1D02F9.4000503@ru.mvista.com>
References: <20091206210752.GA19268@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:44300 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757007AbZLGN1F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 08:27:05 -0500
In-Reply-To: <20091206210752.GA19268@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello.

Jeff Garzik wrote:

> Nothing world-shakingly-notable.  Notable notables:

> - TRIM work from Christoph and mkp, to make SSD life a bit better
> - PATA fixes and updates from Bart and Alan
> - long overdue removal of 'experimental' tag from PATA driver submenu
>   in Kconfig
> - various bug fixes and minor updates

> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

> to receive the following updates:

[...]

> Alan Cox (6):
>       pata_via: Blacklist some combinations of Transcend Flash and via
>       pata_sis: Implement MWDMA for the UDMA 133 capable chips

    Unfortunately, this patch contains a coding mistake. Probably too late 
to correct it now though Linus hasn't pulled as yet...

MBR, Sergei
