From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: error rate statistic
Date: Mon, 04 Jul 2011 08:42:23 +0200
Message-ID: <1309761743.25262.21.camel@zwerg>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:37964 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755273Ab1GDGm0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2011 02:42:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hallo all,

I currently working on instruments for early recognition of hardware
errors. One of the biggest problems are hard drives (i know, you know
it)... i can't use smart because it completely  fails in some cases.
Good indicator is kernel log, but it make no sense to parse it all the
time.

My question is: are there any sysfs interface to check for io errors on
some drive? I see there is  /sys/block/<dev>/stat interface, is it
possible to add it there or add a new file?


-- 
Regards,
        Alexey

