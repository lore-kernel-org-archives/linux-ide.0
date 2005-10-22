From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata: clustering turned on
Date: Sat, 22 Oct 2005 00:20:44 -0400
Message-ID: <4359BE1C.8040602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16570 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932584AbVJVEUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Oct 2005 00:20:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>

As promised, I just committed a patch which turns on block layer 
clustering in libata.  Shouldn't break anything, but testers of 
'upstream' branch are welcome to try!

	Jeff


