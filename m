From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 12:51:03 +0200
Message-ID: <43046817.803@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4614 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S932183AbVHRKvP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 06:51:15 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id C1DF42F016
	for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 12:51:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 9CB2712218
	for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 12:51:05 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id D5A3E121BC
	for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 12:51:04 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

According to an (old) man page of sync(2)

        According to  the  standard  specification  (e.g.,  SVID),
        sync()  schedules  the  writes,  but may return before the
        actual writing is done.   However,  since  version  1.3.20
        Linux  does actually wait.  (This still does not guarantee
        data integrity: modern disks have large caches.)

How about recent kernels? Does sync() block until buffers are flushed?
How can I find out if the disk caches are actually flushed?

I want to make sure that all data is flushed to my disk drive before powering 
down the system.

Thanks.

--
Steven

