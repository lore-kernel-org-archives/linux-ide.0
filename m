From: Tejun Heo <htejun@gmail.com>
Subject: possibly a dumb question about sb600/700
Date: Mon, 12 Nov 2007 18:05:44 +0900
Message-ID: <47381768.2060803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.180]:40883 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbXKLJFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 04:05:52 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1369902roc
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 01:05:51 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: conke.hu@gmail.com
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

I've been looking at PATA support for sb600 and 700 and found something
weird.

* IDE atiixp.c has a separate entry for sb600 such that it only probes
the first port but sb700 doesn't use the entry.  So, does sb600 has one
PATA channel but sb700 has two?

* libata pata_atiixp.c doesn't have special handling for sb600's
single-channeldness.  Is this okay?

Thanks.

-- 
tejun
