From: Mark Lord <lkml@rtr.ca>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 15:43:38 -0500
Message-ID: <479E3E7A.7000308@rtr.ca>
References: <200801272122.21823.gene.heskett@gmail.com> <200801281156.28844.gene.heskett@gmail.com> <479E1CF4.7060706@rtr.ca> <200801281359.24050.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4938 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbYA1Unk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 15:43:40 -0500
In-Reply-To: <200801281359.24050.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

Gene Heskett wrote:
> On Monday 28 January 2008, Mark Lord wrote:
>..
>> Another way is to use the "make_bad_sector" utility that
>> is included in the source tarball for hdparm-7.7, as follows:
>>
>>   make_bad_sector --readback /dev/sda 474507
>>
> Apparently not in the rpm, darnit.
..

That's okay.  It should still be in the SRPM source file.
And it's a tiny download from sourceforge.net:

http://sourceforge.net/search/?type_of_search=soft&type_of_search=soft&words=hdparm

Cheers
