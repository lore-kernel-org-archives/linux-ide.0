From: "Allen Bolderoff" <allen@gist.net.au>
Subject: RE: Promise SATAII150 TX4: strange disk ordering
Date: Fri, 26 Aug 2005 12:35:20 +0930
Message-ID: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gist.net.au ([203.20.102.8]:14993 "EHLO mail.gist.net.au")
	by vger.kernel.org with ESMTP id S1750773AbVHZDF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 23:05:29 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

> driver" and introducing driver options to manually order the ports?
> 
> How can I ensure stable device names (/dev/sd*)?
> 

I use LVM.

However - this card/driver is known to break when using more than 1
drive at a time (ie accessing 2 or 3 drives at once) 




