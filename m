From: David Miller <davem@davemloft.net>
Subject: Re: Bug#590327: linux-image-2.6.32-5-amd64: Unbalanced enable for
 IRQ 19
Date: Wed, 07 Sep 2011 01:16:13 -0400 (EDT)
Message-ID: <20110907.011613.391683420146319494.davem@davemloft.net>
References: <1315368967.3092.430.camel@deadeye>
	<20110907.003931.1112417911793078586.davem@davemloft.net>
	<1315371519.3092.457.camel@deadeye>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:41447 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab1IGFQY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2011 01:16:24 -0400
In-Reply-To: <1315371519.3092.457.camel@deadeye>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben@decadent.org.uk
Cc: linux-ide@vger.kernel.org, 590327@bugs.debian.org, jan@goneko.de

From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 07 Sep 2011 05:58:33 +0100

> Well, I'm concerned with what to do in distro configurations which
> aren't just for 'modern systems'.  We already swapped over all the
> drivers not labelled as experimental.  With the rest, I worry that we'd
> be exchanging obscure IDE drivers that mostly work for obscure libata
> drivers that have had little if any testing.  That strikes me as being
> even more risky for the users with the old controllers.
> 
> I suppose that for those controllers where the libata driver is
> experimental we could build both drivers, blacklist the IDE drivers and
> let people override that if necessary.  (And hope that most of the bugs
> get shaken out of the libata drivers before we do a stable release,
> because that is too ugly to keep doing for long.)

But for the cases these bugs are hitting these are systems the old
drivers never could have worked on, because of the IRQ sharing issue
with things like USB controllers.

I think your blacklisting idea probably makes the most sense.
