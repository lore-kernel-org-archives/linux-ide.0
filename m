From: Nicola <ivololeribar@yahoo.it>
Subject: Re: SiS 180 pata
Date: Mon, 5 Jul 2004 16:03:48 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407051603.48708.ivololeribar@yahoo.it>
References: <200407051253.47003.ivololeribar@yahoo.it> <40E95B1D.3080501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:4283 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266120AbUGEODo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 10:03:44 -0400
In-Reply-To: <40E95B1D.3080501@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: uwe.koziolek@gmx.net, linux-ide@vger.kernel.org

On Monday 05 July 2004 15:43, you wrote:

> > Now I'm quite confused. Does the sata_sis module covers only the sata
> > side
>
> Correct...   as the name implies.
>
> You need to add PCI ids to the SIS IDE driver.
>
> 	Jeff
I've added the id few days ago (not yet approved):
http://pciids.sourceforge.net/iii/?i=1039

should be something like:
{ "SiS180",     PCI_DEVICE_ID_SI_180,   ATA_133   },
inside sis5513.c

May I help somehow in developping/testing the pata driver?
Please let me know

Thank you
Nicola
