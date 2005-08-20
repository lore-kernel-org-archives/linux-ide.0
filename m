From: Jeff Garzik <jgarzik@pobox.com>
Subject: More libata EH data points
Date: Sat, 20 Aug 2005 02:51:30 -0400
Message-ID: <4306D2F2.9000309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12001 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751239AbVHTGvf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 02:51:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

Check out this lkml thread: 
http://marc.theaimsgroup.com/?t=111709353400001&r=1&w=2

It may help to turn on CONFIG_DEBUG_SLAB...

	Jeff


