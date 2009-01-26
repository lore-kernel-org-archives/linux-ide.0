From: Felix Miata <mrmazda@ij.net>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Mon, 26 Jan 2009 14:04:32 -0500
Message-ID: <497E0940.3020409@ij.net>
References: <20090120002923.065f24ca@diego-desktop> <49753D09.8060503@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fall-lakeland.atl.sa.earthlink.net ([207.69.195.103]:54622 "EHLO
	fall-lakeland.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751723AbZAZTPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:15:45 -0500
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72])
	by fall-lakeland.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1LRWvx-00072p-0m
	for linux-ide@vger.kernel.org; Mon, 26 Jan 2009 14:15:45 -0500
Received: from user-142gt2m.cable.mindspring.com ([72.40.116.86] helo=[192.168.0.51])
	by pop-sarus.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1LRWl4-0007RW-00
	for linux-ide@vger.kernel.org; Mon, 26 Jan 2009 14:04:30 -0500
In-Reply-To: <49753D09.8060503@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2009/01/19 20:55 (GMT-0600) Robert Hancock composed:

> There are a few drives which are currently marked to disable NCQ and 
> warn the user that the firmware that should be upgraded:

> ST31500341AS
> ST31000333AS
> ST3640623AS
> ST3640323AS
> ST3320813AS
> ST3320613AS

> all for firmware versions SD15 through SD19.

I just got off the phone with Seagate tech because I could not find out
whether the SD22 firmware in my ST3320613AS was an affected version. He said
that it was and recommended I upgrade.

The "Drive Detect software" that
http://seagate.custkb.com/seagate/crm/selfservice/search.jsp?DocId=207957
directs to use to discover the firmware revision requires windoz. Anyone know
if it works under Wine? Instead I used a bootable Seatools CD that came in a
retail Seagate HD package.
-- 
"Train a child in the way he should go, and when he
is old he will not turn from it." Proverbs 22:6 NIV

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
