From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 180 pata
Date: Sun, 11 Jul 2004 23:46:13 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089582373.2554.8.camel@uk3.local>
References: <200407051253.47003.ivololeribar@yahoo.it>
	 <200407071154.48626.bzolnier@elka.pw.edu.pl>
	 <200407071202.55091.bzolnier@elka.pw.edu.pl>
	 <200407071618.43587.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:6097 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266533AbUGKVqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jul 2004 17:46:00 -0400
In-Reply-To: <200407071618.43587.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Nicola <ivololeribar@yahoo.it>

Hello Jeff,

will you support this specific constellation?, or should i try to
implemenent master/slave support to sata_sis and hope this will solve
the problem.

regards
Uwe


> > eh, 3 not 4 - 2 from SiS5513 and 1 from SiS180
> > (http://www.jetway.com.tw/evisn/product/amd/S755MAX/S755MAX.jpg)
> Correct. 2 pata from 5513, 1 pata and 2 sata from 180. The 180 has no bios 
> cyl/head stuff entry, just on/off and if booting before or after scsi - the 
> latter is not onboard.


