From: Mark Lord <liml@rtr.ca>
Subject: Re: Make_bad_sector
Date: Tue, 29 Jan 2008 11:16:25 -0500
Message-ID: <479F5159.60505@rtr.ca>
References: <87f94c370801290739t39640bf5w960576ae4b273156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3454 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765692AbYA2QQ1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 11:16:27 -0500
In-Reply-To: <87f94c370801290739t39640bf5w960576ae4b273156@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, Philipp Thomas <pth@suse.de>, Gene Heskett <gene.heskett@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On Jan 28, 2008 3:43 PM, Mark Lord <lkml@rtr.ca> wrote:
>> Gene Heskett wrote:
>>> On Monday 28 January 2008, Mark Lord wrote:
>>> ..
>>>> Another way is to use the "make_bad_sector" utility that
>>>> is included in the source tarball for hdparm-7.7, as follows:
>>>>
>>>>   make_bad_sector --readback /dev/sda 474507
>>>>
>>> Apparently not in the rpm, darnit.
>> ..
>>
>> That's okay.  It should still be in the SRPM source file.
>> And it's a tiny download from sourceforge.net:
>>
>> http://sourceforge.net/search/?type_of_search=soft&type_of_search=soft&words=hdparm
>>
> Mark,
> 
> I asked on the SUSE list and was informed by Philipp Thomas of Novell
> (cc'ed) that the only mention of make_bad_sector in the hdparm-7.7
> source is in a todo list.
> 
> Sounds like a useful tool, so I was hoping to encourage suse to
> include it with future releases.
..

Shoot!  You are correct, dagnabbit.
I'll have to put out a new release soonish, then.

Cheers
