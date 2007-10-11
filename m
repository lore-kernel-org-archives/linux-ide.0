From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Thu, 11 Oct 2007 00:00:20 -0400
Message-ID: <76366b180710102100t42572966v655d24c6fd7c90c1@mail.gmail.com>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
	 <4707ECF0.9030800@gmail.com>
	 <76366b180710072251i7af01faaqc18776d8f8f31ef9@mail.gmail.com>
	 <4709C8D6.3020008@gmail.com>
	 <76366b180710072332o159d2364i6fe5e0d5e28c0944@mail.gmail.com>
	 <Pine.LNX.4.63.0710101435340.4797@trinity.phys.uwm.edu>
	 <470D843B.3030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:44663 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbXJKEAW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2007 00:00:22 -0400
Received: by py-out-1112.google.com with SMTP id u77so777035pyb
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2007 21:00:21 -0700 (PDT)
In-Reply-To: <470D843B.3030405@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>, Tejun Heo <htejun@gmail.com>
Cc: Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Bruce/Tejun,

Just so you both know, even when specifying '-n standby,q' in smartd,
it still triggers timeouts on my system. The timeouts are no longer
coming from the default half-hour checks, but from my configured
self-test times with the '-s' option. It appears smartd overrides the
'-n' parameter in this case, triggering the libata soft reset. This is
another case that would be fixed if libata does the SRST
automatically.

Thanks,
-Andrew

Oct 11 02:16:52 (none) daemon.info smartd[23848]: Device: /dev/sdb,
STANDBY mode ignored due to scheduled self test (47 checks skipped)
Oct 11 02:17:03 (none) user.err kernel: ata2.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 11 02:17:03 (none) user.err kernel: ata2.00: cmd
b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
Oct 11 02:17:03 (none) user.warn kernel:          res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Oct 11 02:17:08 (none) user.warn kernel: ata2: port is slow to
respond, please be patient (Status 0xd0)
Oct 11 02:17:10 (none) user.info kernel: ata2: soft resetting port
Oct 11 02:17:10 (none) user.info kernel: ata2: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Oct 11 02:17:10 (none) user.info kernel: ata2.00: configured for UDMA/100
Oct 11 02:17:10 (none) user.info kernel: ata2: EH complete

On 10/10/07, Tejun Heo <htejun@gmail.com> wrote:
> Maybe what should be done is to track sleep mode in libata and issue
> SRST automatically if a command is issued to a sleeping drive.  I'll
> work on it.
