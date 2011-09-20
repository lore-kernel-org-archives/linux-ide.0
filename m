From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] Merge pata_of_platform.c into pata_platform.c
Date: Tue, 20 Sep 2011 10:53:22 +0100
Message-ID: <CA+wbFddrRDz5sxWcwh3QMXKJDbGDZbhfDeiiRvxdwQ-4D5Ad5g@mail.gmail.com>
References: <20110917213532.20710.92002.stgit@ponder>
	<20110919163850.GA2108@arm.com>
	<20110919171055.GA30517@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50392 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab1ITJxX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2011 05:53:23 -0400
In-Reply-To: <20110919171055.GA30517@ponder.secretlab.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 19, 2011 at 6:10 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Mon, Sep 19, 2011 at 05:39:02PM +0100, Dave Martin wrote:
>> On Sat, Sep 17, 2011 at 03:36:19PM -0600, Grant Likely wrote:
>> > There is no need for two drivers anymore
>> >
>> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> > Cc: Dave Martin <dave.martin@linaro.org>
>> > COMPILE TESTED ONLY
>> > ---
>> > [resend - I flubbed Dave's email address]
>> >
>> > Dave, as I mentioned in the other thread, this is the patch that I
>> > hacked together to get rid of pata_of_platform.c. =A0Can you take =
over
>> > on this patch please?
>>
>> This seems to work for me on vexpress.
>>
>> Can you clarify what you mean by "take over"?
>
> Adopt it. =A0Give it a home. =A0Shepherd it to help it find it's way =
into
> mainline. =A0:-)
>
> The patch isn't complete. =A0I've not cleaned up the Kconfig or Makef=
ile
> and it needs some more due diligence to review and make sure that the
> pata_of_platform functionality has moved into pata_platform.c.

OK, assume for now that I will own this fow now -- If I get stuck,
I'll come back to you.

Cheers
---Dave
