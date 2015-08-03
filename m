From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sata_sx4: Check return code from pdc20621_i2c_read()
Date: Mon, 03 Aug 2015 12:09:21 -0700
Message-ID: <1438628961.4601.2.camel@perches.com>
References: <55BF8E29.6000200@cogentembedded.com>
	 <1438627595-17126-1-git-send-email-barletz@gmail.com>
	 <55BFB87C.1010405@cogentembedded.com>
	 <CAO-S75BnJJvNsEN3xFrtO9xO=4=UnwJeL6UHLeMbOaSyjk4Htw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:37977 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754342AbbHCTJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2015 15:09:24 -0400
In-Reply-To: <CAO-S75BnJJvNsEN3xFrtO9xO=4=UnwJeL6UHLeMbOaSyjk4Htw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2015-08-03 at 12:04 -0700, Tomer Barletz wrote:
> I see how it makes sense to add a tab to align with the previous line
> of code, as it will always look similar in all editors, no matter how
> their tab character is set up to be.
> However, adding more tabs will just mess up editors that are not set
> up with 8-space width tabs.
> 
> Is this a bug in checkpatch.pl, or are we saying everyone should have
> their editor set to 8-spaces width tabs?

from Documentation/CodingStyle:

		Chapter 1: Indentation

Tabs are 8 characters, and thus indentations are also 8 characters.
There are heretic movements that try to make indentations 4 (or even 2!)
characters deep, and that is akin to trying to define the value of PI to
be 3.

Rationale: The whole idea behind indentation is to clearly define where
a block of control starts and ends.  Especially when you've been looking
at your screen for 20 straight hours, you'll find it a lot easier to see
how the indentation works if you have large indentations.

Now, some people will claim that having 8-character indentations makes
the code move too far to the right, and makes it hard to read on a
80-character terminal screen.  The answer to that is that if you need
more than 3 levels of indentation, you're screwed anyway, and should fix
your program.

In short, 8-char indents make things easier to read, and have the added
benefit of warning you when you're nesting your functions too deep.
Heed that warning.

