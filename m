From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Bogus LBA48 drives
Date: Wed, 31 Mar 2004 13:58:09 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406B14C1.8000708@pobox.com>
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be> <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org> <20040331183410.GA3796@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262311AbUCaS62
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2004 13:58:28 -0500
In-Reply-To: <20040331183410.GA3796@pclin040.win.tue.nl>
List-Id: linux-ide@vger.kernel.org
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andre Hedrick <andre@linux-ide.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Andries Brouwer wrote:
> Hmm. I read in my copy of ATA7:
> 
>  6.16.55 Words (103:100): Maximum user LBA for 48-bit Address feature set
>  Words (103:100) contain a value that is one greater than the maximum LBA
>  in user accessable space when the 48-bit Addressing feature set is supported.
>  The maximum value that shall be placed in this field is 0000FFFFFFFFFFFFh.
>  Support of these words is mandatory if the 48-bit Address feature set is supported.
> 
> Do you read differently?

The errata is, one needs to check that field for zero, and use the other 
one if so...

	Jeff



