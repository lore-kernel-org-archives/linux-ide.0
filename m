From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Tue, 30 Oct 2007 13:52:25 +0300
Message-ID: <47270CE9.4060501@msgid.tls.msk.ru>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:20916 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbXJ3Kw3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 06:52:29 -0400
In-Reply-To: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Matheus Izvekov wrote:
> Seagate drive ST3160023AS is correctly detected as supporting NCQ, but
> when its used with moderate loads, libata keeps throwing error
> messages until it finally decides to disable NCQ on it.
[]
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-6: ST3120026AS, 3.18, max UDMA/133

By the way, did you forget to remove a jumper on the drive
(the only jumper installed by default) that limits drive
usage to SATAI?

[]
> ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata4.00: cmd 61/1f:00:f4:14:52/00:00:09:00:00/40 tag 0 cdb 0x0 data 15872 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4: soft resetting port
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

..etc.   Try again without the jumper?  Note that NCQ is NOT supported
in SATAI mode, or there were some pre-standard implementations of it.
In SATAII, NCQ is standard (well... more or less anyway ;)

/mjt
