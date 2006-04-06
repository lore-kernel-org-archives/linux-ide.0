From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata machine check on Alpha
Date: Wed, 05 Apr 2006 22:17:33 -0400
Message-ID: <44347A3D.1000609@garzik.org>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com> <44347713.9000408@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15261 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932123AbWDFCRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 22:17:38 -0400
In-Reply-To: <44347713.9000408@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>, Tejun Heo <htejun@gmail.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org

Albert Lee wrote:
> Per Jeff's comment, there is a document on t13 (http://www.t13.org/do=
cs2003/e03131r0.pdf).
> The documents reads:
> "Eg. =96 Word 50, bit 13: Set to 1 for devices that support DMAIN bit=
 in Features Register for Packet Command".
> However, this looks more for the ATAPI device than for the bridge?
> Also it looks not a t13 standard yet?
> Can we use this word 50 to identify 3611/3811?


DMADIR is in my copy of ATA-7...

	Jeff


