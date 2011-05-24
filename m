From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [GIT PULL] Start of removal of legacy parallel interfaces for
  3.0
Date: Tue, 24 May 2011 20:42:56 +0200
Message-ID: <4DDBFC30.6030201@fusionio.com>
References: <4DDBF40E.7020003@fusionio.com> <BANLkTi=sYVpvEwShbhC65qfaA0Jt3rEjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.fusionio.com ([66.114.96.31]:57963 "EHLO mx2.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab1EXSnB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 May 2011 14:43:01 -0400
In-Reply-To: <BANLkTi=sYVpvEwShbhC65qfaA0Jt3rEjsQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>, Chris Mason <chris.mason@oracle.com>

On 2011-05-24 20:37, Linus Torvalds wrote:
> On Tue, May 24, 2011 at 11:08 AM, Jens Axboe <jaxboe@fusionio.com> wrote:
>>
>> With the 3.0 kernel approaching, now is a great time to get rid of some
>> legacy bagage. And what better part to start with than the old IDE code.
>> Parallel interfaces are so 1990's, we can't be seen with those on a
>> fancy new kernel version.
> 
> No.
> 
> Guys. Really.
> 
> Any version numbering change is *not* an excuse to drop any old stuff,
> or do anything new and exciting.

Boy, you guys sure are humorless. I would've thought the reference to
killing SCSI next would be a good clue.

So we can't kill x86 32-bit either?

-- 
Jens Axboe

