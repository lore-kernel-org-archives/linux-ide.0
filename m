From: Nicola <ivololeribar@yahoo.it>
Subject: Re: SiS 180 pata
Date: Mon, 5 Jul 2004 23:30:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407052330.11813.ivololeribar@yahoo.it>
References: <200407051253.47003.ivololeribar@yahoo.it> <200407052305.29015.ivololeribar@yahoo.it> <1089062694.2868.20.camel@uk3.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:34384 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262450AbUGEVaH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 17:30:07 -0400
In-Reply-To: <1089062694.2868.20.camel@uk3.local>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 05 July 2004 23:24, Uwe Koziolek wrote:
> Hello Nicola,
>
> please provide the complete output of lspci -vvxxx, not only the the
> device 1039:0180. I want to see, if there is a different IDE-Adapter
> to SIS5513/18 and SiS180.
> If not, the pata ports may be the slaves on SIS180.
Another thing I noticed:
when the interface has no disks, the bios labels primary and secondary master 
as SATA, other interfaces as slave (not speciified).
When I attach a pata drive, however, it is recognised from the bios as primary 
master (jumpered as master, of course).

Thanks
Nicola
