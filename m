From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: matching bus and block subsystem?
Date: Tue, 19 Jul 2005 17:52:57 +0200
Message-ID: <42DD21D9.2050805@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:44295 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261430AbVGSPw7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jul 2005 11:52:59 -0400
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 284EC2F017
	for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2005 16:00:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 68FC612100
	for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2005 17:52:58 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id A7DFF11CAA
	for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2005 17:52:57 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

I am a bit confused by all the links in my sysfs.

My application has to find out which block devices (HDDs) are connected via the 
bus PCMCIA and which are connected directly to the IDE controller.

How could I figure out if a block device "hda" is actually connected to the bus 
"pcmcia"?

Thanks a million.

-- 
Steven
