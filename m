From: matthieu castet <castet.matthieu@free.fr>
Subject: EZD driver and hdx=remap.
Date: Sat, 17 Sep 2005 22:34:50 +0200
Message-ID: <432C7DEA.9060103@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:25742 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751191AbVIQUe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2005 16:34:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi,

I spend lot's of hours to figure that my kernel need hdx=remap to 
understand EZD disk.

It was very long because I had to figure it have something to do with 
EZD and then find the solution (easy).

If EZD drive are not remapped, why in fs/partitions/msdos.c, there 
aren't some info in case of EZD driver about hdx=remap option ?

Futhermore it will much cleanner to panic in this case, as log spaming 
could mask the message.

Matthieu
