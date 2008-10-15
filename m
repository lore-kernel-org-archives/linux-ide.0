From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_via "frozen" DVD drive (TSSTcorp SN-S083A on EPIA EX15000)
Date: Wed, 15 Oct 2008 16:17:14 +0900
Message-ID: <48F598FA.9060500@kernel.org>
References: <338a6b6d0810140230t16f8da53y6facbcee174cad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48490 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbYJOHSp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 03:18:45 -0400
In-Reply-To: <338a6b6d0810140230t16f8da53y6facbcee174cad3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Jonas Jensen wrote:
> I'm running kernel 2.6.26.5 no patches and came across this after
> installing a new DVD drive. This is a Samsung SN-S083A slimline
> optical connected with SATA cable to VIA EPIA EX15000 motherboard. I
> get the exception trying a blank command such as "wodim dev=0,1,0
> blank=fast".
> 
> HDD and DVD are detectable only with pata_via, this seems strange as
> they are SATA drives connected with SATA cable. I have tried both AHCI
> and sata_via, leaving out pata_via, but that always ends up in
> kernelpanic and unbootable root filesystem. I assume no drives were
> found (kernel text scrolls too fast to read).

VIA added SATA support to what used to be PATA controllers and the
naming got kind of meaningless.  It just doesn't really matter
anymore.

> When the DVD fails it seems to drag the HDD with it. Eventually the
> HDD comes back but after that the DVD is nowhere to be found. I am
> unsure what I can do to fix this issue but changing kernel is
> definately an option if that helps.
> 
> syslog:
> 
> Oct 13 20:51:56 silverstone kernel: ata1.01: exception Emask 0x0 SAct
> 0x0 SErr 0x0 action 0x6 frozen
> Oct 13 20:51:56 silverstone kernel: ata1.01: cmd
> a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0
> Oct 13 20:51:56 silverstone kernel:          cdb 54 01 00 00 00 00 00
> 00  00 00 00 00 00 00 00 00
> Oct 13 20:51:56 silverstone kernel:          res

The drive times out SEND_OPC and then never comes back.  The command
is non-data command which just tells the drive to perform calibration,
so there's nothing much the driver can do wrong about it.  It looks
like the drive could have hardware problem performing OPC.  Can you
test the drive under different operating system or different hardware
configuration (different controller, different media, etc...)?

Thanks.

-- 
tejun
