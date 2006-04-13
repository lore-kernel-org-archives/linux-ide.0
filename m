From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-pata works on ICH4-M
Date: Thu, 13 Apr 2006 18:30:07 -0400
Message-ID: <443ED0EF.6080909@rtr.ca>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu> <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr> <443ECEBF.9050604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:21425 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965005AbWDMWaK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 18:30:10 -0400
In-Reply-To: <443ECEBF.9050604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Gabor Gombas <gombasg@sztaki.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org

And actually, "hdparm -Mnnn /dev/sda" does work today.

So it can set the Acoustic parameters just fine,
it just cannot read back the setting.

Cheers
