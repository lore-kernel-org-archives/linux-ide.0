From: "tea4two" <tea4two@tin.it>
Subject: Re: dma_timer_expiry on SATA siimage 3112 under 2.6.0-test1-ac1
Date: Thu, 17 Jul 2003 23:22:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <bf7419$a6b$1@main.gmane.org>
References: <1058389994.3220.20.camel@daedalus.samhome.net> <bf6nb0$c3$1@main.gmane.org> <1058466147.3220.62.camel@daedalus.samhome.net> <bf72m5$2p5$1@main.gmane.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:13013 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271289AbTGQVH5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jul 2003 17:07:57 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 19dGCD-0002j2-00
	for <linux-ide@vger.kernel.org>; Thu, 17 Jul 2003 23:21:49 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

A little trick.... Previous contain a mistake

During Linux install switch in a console and run the command
hdparm -d1 -Xudma2 /tmp/hde.....   ;-))))

Installation time is more faster.... (for me from 1 hour and 30 minutes drop
to 25 minutes......)

I think that driver is not mature  and need improvement....I hope ASAP.

Bye



