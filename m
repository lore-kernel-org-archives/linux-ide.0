From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: FW: hdparm ATA Security Options return errors
Date: Thu, 27 Oct 2005 21:02:08 +0200
Message-ID: <43612430.702@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF0B@WDSCEXBECL03.sc.wdc.com>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:62427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751558AbVJ0TCf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2005 15:02:35 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF0B@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

ok tim. your app works, except that no maximum security can be set on my
old 20gb seagate (max supported) ata5 on kernel
2.6.13.4+passthrough...2.6.14-rc5-mm and drive status error handling is
incomplete and gives one false ok message after some command...

hdparm works too now, must be an issue on unlocking with NULL password i
used for 1. test on the linux-ide list...

tested with ata5-6 seagate/ibm desktop drives.

enhanced erase not tested cause not supported by the drives.

BTW: AMI Bios here freezes ata-security on at least ide0 PM drive on
power on without any option to turn freeze off, THATS NOT VERY NICE
cause this FORBIDS security use, i had to test on the sil680 controller :(

y
tom
