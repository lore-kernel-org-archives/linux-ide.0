From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
Date: Mon, 25 May 2009 15:10:40 -0400
Message-ID: <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	<1243230339.9819.18.camel@localhost.localdomain>
	<4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>
	<4A1AEBF7.7040402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:17988 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZEYTLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 15:11:46 -0400
In-Reply-To: <4A1AEBF7.7040402@ru.mvista.com> (Sergei Shtylyov's message of
	"Mon, 25 May 2009 23:05:27 +0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, =?utf-8?B?6IOh5rSq?= =?utf-8?B?5YW1?= <huhb@lemote.com>, yanh@lemote.com, wuzhangjin@gmail.com, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Philippe Vachon <philippe@cowpig.ca>, Zhang Le <r0bertz@gentoo.org>, Zhang Fuxin <zhangfx@lemote.com>, Arnaud Patard <apatard@mandriva.com>, loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org, Nicholas Mc Guire <hofrat@hofr.at>, Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>

>>>>> "Sergei" == Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

>> Could you please explain the issue with platform specific code a bit
>> more?

>> Is it related to a cable detection by any chance?

Sergei>    I guess it's rdmsr()/wrmsr()...

Those are only used when the driver is explicitly loaded with
use_msr=1.  The default is to use PCI config space/VSA.

In any case I have yet to see a CS5536 system whose BIOS sets the cable
detection bit.  If that's the problem I guess we could add a quirk flag
to override the (lack of) BIOS setting.

-- 
Martin K. Petersen	Oracle Linux Engineering

