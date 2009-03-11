From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Wed, 11 Mar 2009 12:28:05 +0900 (JST)
Message-ID: <20090311032805.3120.qmail@web4114.mail.ogk.yahoo.co.jp>
References: <20090311030340.GA617@psychosis.jim.sh>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web4114.mail.ogk.yahoo.co.jp ([124.83.200.76]:38509 "HELO
	web4114.mail.ogk.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753616AbZCKD2J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 23:28:09 -0400
In-Reply-To: <20090311030340.GA617@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, n0diamond@yahoo.co.jp

Jim Paris wrote:
> Norman Diamond wrote:
>>
>> It looks like both LIBATA and the old IDE drivers
>> have an off-by-one error in deciding whether to use
>> READ SECTOR(S) instead of READ SECTOR(S) EXT.
> 
> This was fixed here:
>
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=97b697a11b07e2ebfa69c488132596cc5eb24119

Thank you.

I will see if I can port that fix to 2.6.24.3, because
Slax 6.0.3 and kernel 2.6.24.3 avoided some other bugs of
later kernels.


--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
