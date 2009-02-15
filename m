From: Mark Lord <mlord@pobox.com>
Subject: Re: SATL support for hdparm?
Date: Sat, 14 Feb 2009 19:20:20 -0500
Message-ID: <49975FC4.9090600@pobox.com>
References: <20090214222114.GI17914@xi.wantstofly.org>
 <49975A6D.4010608@pobox.com> <20090215000603.GK17914@xi.wantstofly.org>
 <49975D28.4050101@pobox.com> <20090215001355.GL17914@xi.wantstofly.org>
 <49975EA8.4090804@pobox.com> <20090215001750.GM17914@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZBOAU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:20:27 -0500
In-Reply-To: <20090215001750.GM17914@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

Lennert Buytenhek wrote:
,,
>>  hdparm --verbose -B /dev/sdb
> 
> 	[root@heth hdparm-9.10]# ./hdparm --verbose -B 254 /dev/sdb
> 
> 	/dev/sdb:
> 	 setting Advanced Power Management level to 0xfe (254)
> 	outgoing cdb:  a1 06 20 05 fe 00 00 00 40 ef 00 00 00 00 00 00
> 	SG_IO: ATA_12 status=0x2, host_status=0x0, driver_status=0x8
> 	SG_IO: sb[]:  72 0b 00 00 00 00 00 0e 09 0c 00 04 00 fe 00 00 00 00 00 00 40 51 00 00 00 00 00 00 00 00 00 00
> 	SG_IO: desc[]:  09 0c 00 04 00 fe 00 00 00 00 00 00
> 	      ATA_12 stat=51 err=04 nsect=fe lbal=00 lbam=00 lbah=00 dev=40
..

Ahh.. there ya go.  Mmmm.. You *could* try again with hdparm-9.11
(on Sourceforge now.. forgot to upload it earlier).

The difference being, 9.11 will use ATA_16 instead of ATA_12 by default for SAT.
Some enclosures care about that, but drives shouldn't care.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
