From: "John Stoffel" <john@stoffel.org>
Subject: Re: 2.6.18-rc5 - HPT302 wierdness
Date: Wed, 30 Aug 2006 10:04:10 -0400
Message-ID: <17653.39642.605716.215981@smtp.charter.net>
References: <17652.55275.556545.19616@smtp.charter.net>
	<1156932104.6271.138.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:9860 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751061AbWH3OEN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Aug 2006 10:04:13 -0400
In-Reply-To: <1156932104.6271.138.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org



Alan> Ar Maw, 2006-08-29 am 20:12 -0400, ysgrifennodd John Stoffel:
>> The drives are identical, and bought at the same time, yet on bootup
>> of 2.6.18-rc5, they show up with different values for CHS and for Max
>> Request Size.

Alan> One is using LBA48 the other is not. Looks like you have two
Alan> very different firmwares

Thanks Alan, looking at them, the firwares are quite different.  I'm
going to see about upgrading the down-rev one if possible, and I'll
check my third 120gb drive which is in an un-powered external
enclosure right now.  Whee!

Thanks,
John
