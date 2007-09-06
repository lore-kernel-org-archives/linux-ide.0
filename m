From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Thu, 6 Sep 2007 01:33:47 +0100
Message-ID: <20070906013347.1f588dc4@the-village.bc.nu>
References: <124748.3608.qm@web54408.mail.yahoo.com>
	<1188982210.3075.9.camel@castor.rsk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mobileweb01.london.02.net ([193.113.235.167]:58170 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932193AbXIFAmB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 20:42:01 -0400
In-Reply-To: <1188982210.3075.9.camel@castor.rsk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: richard kennedy <richard@rsk.demon.co.uk>
Cc: Vlad <vladc6@yahoo.com>, linux-ide@vger.kernel.org

> Unfortunately I don't have another machine to try these drives in. But
> they both worked OK under the old ide code -- the problems only started
> with the move to libata.
> 
> I guess the commands timing out are udev probing to see if a disk has
> been inserted ?

Probably. If you can file a bug in bugzilla and assign it to me I'll take
a look at this after the kernel summit. There are one or two reports with
pata_via and ATAPI (ie CD) that look similar.
