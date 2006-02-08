From: Gabriele Gorla <gorlik@yahoo.com>
Subject: SIL3114 problem on alpha
Date: Wed, 8 Feb 2006 14:31:41 -0800 (PST)
Message-ID: <20060208223141.18180.qmail@web53709.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web53709.mail.yahoo.com ([206.190.37.30]:28565 "HELO
	web53709.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965210AbWBHWbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 17:31:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,
I tried to use a SIL3114 based card on my PC164SX
alpha based motherboard.

Channel 0 and 1 seem to work fine but 2 and 3 report
frequent read errors.
Adding the SIL_FLAG_MOD15WRITE makes everything happy.
However the same card and drives on a standard PC i386
platform do not require the SIL_FLAG_MOD15WRITE flag
for proper operaion.

The only difference I can think of is that on the
alpha platform the add-on card bios is not executed.
I suspect that the card BIOS is adjusting some
register to workaround the MOD15WRITE issue.

do you have any suggestion and/or tools to compare the
register seetings to help figuring out how the bios is
working around the issue?
thanks,
GG

system config:
Alpha 21164PC-533 512Mb
linux 2.6.15.3
3x ST380023AS

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
