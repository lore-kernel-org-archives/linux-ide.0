From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Fri, 13 Mar 2009 08:02:30 +0900 (JST)
Message-ID: <20090312230230.95814.qmail@web4110.mail.ogk.yahoo.co.jp>
References: <49B91C98.4090309@rtr.ca>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web4110.mail.ogk.yahoo.co.jp ([124.83.200.72]:20976 "HELO
	web4110.mail.ogk.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754832AbZCLXCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 19:02:34 -0400
In-Reply-To: <49B91C98.4090309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jim Paris <jim@jtan.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, n0diamond@yahoo.co.jp

Mark Lord wrote:
> Norman Diamond wrote:
>> Jim Paris wrote:
>>> Norman Diamond wrote:
>>>>
>>>> It looks like both LIBATA and the old IDE drivers
>>>> have an off-by-one error in deciding whether to
>>>> use READ SECTOR(S) instead of READ SECTOR(S) EXT.

I don't know for sure now but the old IDE drivers
might be OK on this matter.  When hdparm got errors
I thought they were the driver's fault, but now it's
clear it was hdparm's fault.

It still seems doubtful whether LIBATA is fully fixed.

>>> This was fixed here:
>>>
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=97b697a11b07e2ebfa69c488132596cc5eb24119

(Though that patch doesn't mention two suspicious .c
files that compare sector numbers to expressions
1UL << 28 and 1 << 28.)

>> I'm still having trouble after applying the same
>> patch to 2.6.24.3 (applying it three times in order
>> to build Slax).
>> Does hdparm construct its own taskfiles for ATA and
>> SATA in order to produce an error trying to read
>> sector number 0x0fffffff even after I patched the
>> kernel?
> 
> What, *exactly*, do you mean there.

hdparm --read-sector 268435455 /dev/hda
and
hdparm --read-sector 268435455 /dev/sda
still gave errors even after I patched LIBATA in
kernel 2.6.24.3.  The exceptions are Western Digital
drives that apparently accept LBA28 instructions on
that sector number.

> Yes, hdparm constructs its own taskfiles for the
> --read-sector subcommand.

Thank you.  So I think my build of Slax now will work
except for two obscure chipsets under LIBATA, and will
work for every situation that I'm aware of under the
old IDE drivers (though the old IDE drivers will run
unbearably slowly in some cases).

> Are you hitting these errors with the latest hdparm
> (9.12)?

Sorry, I just checked and it's hdparm 8.6.  Anyway
it's a relief to see that I probably have a build
working well enough for present needs, and I just have
to use tools other than that build's version of hdparm
to test it.

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
