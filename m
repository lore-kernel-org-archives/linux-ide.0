From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Bogus LBA48 drives
Date: Thu, 01 Apr 2004 13:24:11 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406C5E4B.4020505@pobox.com>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be> <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org> <20040331183410.GA3796@pclin040.win.tue.nl> <406B14C1.8000708@pobox.com> <Pine.GSO.4.58.0404010933190.12148@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6345 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263028AbUDASYZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2004 13:24:25 -0500
In-Reply-To: <Pine.GSO.4.58.0404010933190.12148@waterleaf.sonytel.be>
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andre Hedrick <andre@linux-ide.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Geert Uytterhoeven wrote:
> On Wed, 31 Mar 2004, Jeff Garzik wrote:
> 
>>Andries Brouwer wrote:
>>
>>>Hmm. I read in my copy of ATA7:
>>>
>>> 6.16.55 Words (103:100): Maximum user LBA for 48-bit Address feature set
>>> Words (103:100) contain a value that is one greater than the maximum LBA
>>> in user accessable space when the 48-bit Addressing feature set is supported.
>>> The maximum value that shall be placed in this field is 0000FFFFFFFFFFFFh.
>>> Support of these words is mandatory if the 48-bit Address feature set is supported.
>>>
>>>Do you read differently?
>>
>>The errata is, one needs to check that field for zero, and use the other
>>one if so...
> 
> 
> Which is not sufficient for `my' drives, since I get disk errors if I just use
> the other capacity field and don't disable LBA48 completely.
> 
> I'll check the ATA specs myself, if I find some time...

If it's reporting the "48-bit feature set supported" but doesn't really 
support it, I'd vote for broken drive :)  Maybe check for a firmware 
update on the manufacturer's web site?

	Jeff




