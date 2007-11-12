From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
 kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 13:12:19 +0900
Message-ID: <4737D2A3.6010103@gmail.com>
References: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.235]:17061 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbXKLEMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 23:12:38 -0500
Received: by qb-out-0506.google.com with SMTP id e11so2441733qbe
        for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 20:12:36 -0800 (PST)
In-Reply-To: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: I Stratford <i.d.stratford@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Hello,

I Stratford wrote:
> The purpose of the mail is to document and share my experience in the
> hope that someone might find it useful, either for debugging their own
> TX4 300-centric system issues or figuring out what is up with
> sata_promise and the TX4 300 in 3Gbps mode. I also wish to offer my
> somewhat unique promise-based system as a test environment for either
> the timeout or kernel panic issues. I obviously have some basic need
> for data integrity of the RAID5, but this system is not in production
> and is therefore more available for testing purposes than the average
> machine with 22 Promise SATA ports..  :)

[cc'ing Mikael Pettersson]

It seems those 3Gbps promise controllers have hard time getting out of
transmission errors.  Is it because hardreset doesn't work?  Can we fix it?

Also, if 3Gbps can't be made reliable on those controllers, how about
limiting it to 1.5Gbps by default with appropriate warning messages?
Without PMP, it's not like we're gonna earn anything by driving the
thing at 3Gbps.

Thanks.

-- 
tejun
