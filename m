From: Jeff Garzik <jeff@garzik.org>
Subject: Re: /dev/sd*
Date: Thu, 10 Aug 2006 08:37:46 -0400
Message-ID: <44DB289A.4060503@garzik.org>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161229AbWHJMh5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 08:37:57 -0400
In-Reply-To: <20060810123643.GC25187@boogie.lpds.sztaki.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Gabor Gombas wrote:
> AFAIR long ago Linus said he'd like just one major number (and thus only
> one naming scheme) for every disk in the system; with /dev/sd* we're now
> getting there.

Yep.  /dev/disk is a long term goal :)

	Jeff


