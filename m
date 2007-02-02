From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 02 Feb 2007 11:13:44 -0500
Message-ID: <45C36338.60803@rtr.ca>
References: <20070202063748.GC1625@htj.dyndns.org>	<45C33BCF.2040506@emc.com>	<45C354CF.1020500@gmail.com> <20070202153929.33f4a806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3006 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945966AbXBBQNp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:13:45 -0500
In-Reply-To: <20070202153929.33f4a806@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan wrote:
>..
> Give it 7 seconds for a command to complete. At that point you need to
> have a chat with the drive since its probably gone AWOL. If you get an
> error within 7 seconds then its different.

7 seconds is not enough for current drives to report back.
Adding another (8 seconds total) is enough, but I prefer to
see a little margin there, so call it 10 seconds.

Cheers
