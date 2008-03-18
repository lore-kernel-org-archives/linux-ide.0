From: "Gabor FUNK" <funk.gabor@hunetkft.hu>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 14:06:18 +0100
Message-ID: <004601c888f8$dbe453a0$152ea8c0@hu.schp.com>
References: <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <20080318045316.GA3959@denix.org> <009501c888d8$7fbfd150$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:52833 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbYCRNGa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Mar 2008 09:06:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>, Denys Dmytriyenko <denis@denix.org>, Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

> 2)  I replaced the MB to a different one, now it is a Gigabyte as
> well, but it has no nvidia/jmicron contollers but ata_piix and achi
> onboard, and - ironically - an addon sil24 card...
> So far, the system running well [knock-knock], under heavy
> stress test, for 3 weeks now, without problems.
> I believe Tejun suggested to try to remove one of the HDD-s
> online to see what happens, I will try this today later on, when
> I am at the server and let you know.

I removed power from one of the drives in question, and besides
losing that disk, nothing extra happened - eg. the rest 7 drives
stayed operational, raid was operational, etc.

G.
