From: Ricky <rickycheng@qnap.com.tw>
Subject: =?utf-8?b?U2F0YV9zaWw=?= performance
Date: Wed, 17 Aug 2005 06:03:47 +0000 (UTC)
Message-ID: <loom.20050817T075816-713@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:25552 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750823AbVHQGGZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 02:06:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5H36-0003KM-Nd
	for linux-ide@vger.kernel.org; Wed, 17 Aug 2005 08:05:16 +0200
Received: from 211-75-85-27.HINET-IP.hinet.net ([211-75-85-27.HINET-IP.hinet.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 08:05:16 +0200
Received: from rickycheng by 211-75-85-27.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 08:05:16 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, all
I get a problem. 
I user kernel version 2.4.27,30.
the driver get devices and I have format and mount it.

I try hdparm -t /dev/sda1, and just reach 28~31MB/sec
I use the seagate and maxtor not in the blacklist.

but I use 2.6.9

it's perfermance can reach 65MB/sec, both two type of HDs.

Does anyone know the reason?

Thx a lot,
Ricky

