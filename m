From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PIIX: config_drive_for_dma() cleanup
Date: Thu, 11 May 2006 21:29:01 +0100
Message-ID: <1147379342.26130.84.camel@localhost.localdomain>
References: <44638A4F.2090502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22714 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750759AbWEKUQ5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 16:16:57 -0400
In-Reply-To: <44638A4F.2090502@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, liknux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 23:02 +0400, Sergei Shtylyov wrote:
> @@ -73,8 +74,6 @@
>   *	PIIX4	errata #15	- Must not read control registers
>   * 				  during a PIO transfer
>   *	440MX   errata #13	- As PIIX4 errata #15
> - *	ICH2	errata #21	- DMA mode 0 doesn't work right
> - *	ICH0/1  errata #55	- As ICH2 errata #21

NAK. The errata are documented carefully so that people know what the
problems are. They have not gone away.


