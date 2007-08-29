From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady
 SeekComplete Error }
Date: Wed, 29 Aug 2007 17:46:57 +0100
Message-ID: <20070829174657.09c7de3c@the-village.bc.nu>
References: <46D59ED2.4000900@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59565 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752974AbXH2Qid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 12:38:33 -0400
In-Reply-To: <46D59ED2.4000900@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> Standards:
>          Likely used: 1

Prehistory

>          LBA, IORDY not likely

No DMA, nothing above PIO2

>          Buffer type: 0002: dual port, multi-sector
>          Buffer size: 1.0kB      bytes avail on r/w long: 4
>          Cannot perform double-word IO

Can't even do double word I/O

The messages with old IDE should be harmless and the current libata IDE
should drive it politely (I debugged a problem the same hardware showed
up for someone else).

Basically your dinosaur is working correctly.

Alan
