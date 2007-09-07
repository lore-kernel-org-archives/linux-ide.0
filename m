From: richard kennedy <richard@rsk.demon.co.uk>
Subject: Re: pata_via cd/dvd timeout problems
Date: Fri, 07 Sep 2007 10:17:14 +0100
Message-ID: <1189156634.3154.5.camel@castor.rsk.org>
References: <124748.3608.qm@web54408.mail.yahoo.com>
	 <1188982210.3075.9.camel@castor.rsk.org>
	 <20070906013347.1f588dc4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4285 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965015AbXIGJRS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Sep 2007 05:17:18 -0400
In-Reply-To: <20070906013347.1f588dc4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vlad <vladc6@yahoo.com>, linux-ide@vger.kernel.org

On Thu, 2007-09-06 at 01:33 +0100, Alan Cox wrote:
> > Unfortunately I don't have another machine to try these drives in. But
> > they both worked OK under the old ide code -- the problems only started
> > with the move to libata.
> > 
> > I guess the commands timing out are udev probing to see if a disk has
> > been inserted ?
> 
> Probably. If you can file a bug in bugzilla and assign it to me I'll take
> a look at this after the kernel summit. There are one or two reports with
> pata_via and ATAPI (ie CD) that look similar.

Hi Alan,
I've created a bug for this

http://bugzilla.kernel.org/show_bug.cgi?id=8986

but somehow I messed up and it didn't get assigned to you and now I
can't change who it's assigned too. Can you take ownership or should I
delete it and start again ?
sorry
Richard
 

