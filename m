From: vlobanov <vlobanov@speakeasy.net>
Subject: drivers/ide/ide.c question
Date: Wed, 15 Dec 2004 22:38:25 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0412152228380.22022@shell3.speakeasy.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail6.speakeasy.net ([216.254.0.206]:54439 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S262615AbULPGi0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Dec 2004 01:38:26 -0500
Received: from shell3.speakeasy.net ([69.17.110.72])
          (envelope-sender <vlobanov@speakeasy.net>)
          by mail6.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 16 Dec 2004 06:38:25 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I was reading through the ide_setup() function, specifically the portion
which scans through the "idex=" parameter options, and I have a
question. It might be silly (and if so, I apologize for the noise), but
I can't seem to grok it.

The comment pertaining to 'static const char *ide_words[] = { ... };'
states that indices -8, -9, and -10 are reserved, in order to ease the
hardcoding of the code that follows. However, as far as I can tell,
these indices are not used anywhere in a significant way --

In the check to ensure that the chipset is not redefined, only indices
(-11 ... -18) play any significant role. And in the big switch
statement, indices (-8 ... -10) are simply dropped into the bad_option
case.

So, what's so special about these indices? Is there any reason why -8
can't be used for other, possibly nefarious :), purposes?

The reason why I ask is that I want to try to fix bug 3907 in
bugzilla.kernel.org, and want to place the "nodma" option right next to
the "dma" option for clarity, but that would require replacing "minus8"
with "ata66" which the comment warns against ominously.

Thanks in advance,
Vadim Lobanov
