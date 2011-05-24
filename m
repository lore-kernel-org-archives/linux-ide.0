From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [GIT PULL] Start of removal of legacy parallel interfaces for 3.0
Date: Tue, 24 May 2011 17:17:42 -0400
Message-ID: <BANLkTimLL0QgNzQrpvGSxng0boOWZQbBiQ@mail.gmail.com>
References: <4DDBF40E.7020003@fusionio.com> <BANLkTi=sYVpvEwShbhC65qfaA0Jt3rEjsQ@mail.gmail.com>
 <4DDBFC30.6030201@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36090 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab1EXVSD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 May 2011 17:18:03 -0400
In-Reply-To: <4DDBFC30.6030201@fusionio.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>, Chris Mason <chris.mason@oracle.com>

On Tue, May 24, 2011 at 2:42 PM, Jens Axboe <jaxboe@fusionio.com> wrote:
> On 2011-05-24 20:37, Linus Torvalds wrote:
>> On Tue, May 24, 2011 at 11:08 AM, Jens Axboe <jaxboe@fusionio.com> wrote:
>>>
>>> With the 3.0 kernel approaching, now is a great time to get rid of some
>>> legacy bagage. And what better part to start with than the old IDE code.
>>> Parallel interfaces are so 1990's, we can't be seen with those on a
>>> fancy new kernel version.
>>
>> No.
>>
>> Guys. Really.
>>
>> Any version numbering change is *not* an excuse to drop any old stuff,
>> or do anything new and exciting.
>
> Boy, you guys sure are humorless. I would've thought the reference to
> killing SCSI next would be a good clue.

If you also referenced "42" everyone would've been in tears.. ;)
