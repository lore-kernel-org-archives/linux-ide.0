From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Wed, 11 Mar 2009 18:10:58 -0600
Message-ID: <49B85312.5030905@gmail.com>
References: <20090311082725.37cb1883@lxorguk.ukuu.org.uk> <20090311083846.5137.qmail@web4112.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbZCLALP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 20:11:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LhYVz-0003Oo-6i
	for linux-ide@vger.kernel.org; Thu, 12 Mar 2009 00:11:11 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2009 00:11:11 +0000
Received: from hancockrwd by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2009 00:11:11 +0000
In-Reply-To: <20090311083846.5137.qmail@web4112.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Norman Diamond wrote:
> Alan Cox wrote:
>> Norman Diamond <n0diamond@yahoo.co.jp> wrote:
>>
>>> It looks like both LIBATA and the old IDE drivers
>>> have an off-by-one error in deciding whether to use
>>> READ SECTOR(S) instead of READ SECTOR(S) EXT.
>> This was fixed some time ago, you need a newer
>> kernel.
> 
> Well, either that or I need an older kernel.  It was also
> fixed in 2.6.20, for which I think there was a ready-made
> Slax distribution.
> 
> On another topic, trying 2.6.20 in whatever Slax
> distribution it was, an Intel ICH7M had DMA enabled on
> both /dev/hda and /dev/hdc.  I understand that the change
> which was made shortly after that is considered to be by
> design not a bug.  In 2.6.20 I didn't even have to type a
> "combined_mode" parameter, it just worked.  I understand
> that the addition and subsequent deletion of the
> "combined_mode" parameter are considered to be by design
> not bugs.  But it is not at all pleasant that my /dev/hda
> runs at 1.3 megabytes per second in 2.6.24.3 and later,
> when it used to run at 45 megabytes per second in 2.6.20. 
> Yeah I know libata is supposed to solve all this stuff. 
> Removed some bugs and added others.

You really shouldn't use the IDE drivers with SATA devices, if that's
what you're talking about as far as the previous behavior. They were
really never designed for it.

> 
> I can't go newer than 2.6.24.3 until I find a version
> where TASKFILEs start working again.  There might not be
> one.  Yeah I know libata is supposed to solve all this
> stuff.  I wonder how much time I'll need and how many
> varieties of hardware I'll have to buy to see if it's
> really fixed.

Realistically, although some people still work on it, testing coverage
of the old IDE drivers is not that great these days, since most
distributions no longer use it. The crusty, byzantine IDE code base
doesn't exactly make it easy for the inexperienced to debug problems,
either..

