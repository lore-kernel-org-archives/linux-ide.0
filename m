From: Jim Paris <jim@jtan.com>
Subject: Re: SATA port multiplier support in 2.6.21
Date: Mon, 20 Jul 2009 22:50:34 -0400
Message-ID: <20090721025034.GA15894@psychosis.jim.sh>
References: <24580821.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jim.sh ([75.150.123.25]:46693 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398AbZGUDAs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jul 2009 23:00:48 -0400
Content-Disposition: inline
In-Reply-To: <24580821.post@talk.nabble.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Learner Study <learner.study@gmail.com>
Cc: linux-ide@vger.kernel.org

Learner Study wrote:
> 
> Hello:
> 
> I understand that SATA port multiplier support was added in 2.6.24.
> I would like to use 2.6.21 and still use port multilplier. Can someone point
> me to a patch I may use to do this? Any other ideas?

There were patches from Tejun (libata-tj-stable) for 2.6.18 and 2.6.22
at one point, but I don't know where you'd find them anymore (the
original site at http://home-tj.org/wiki/index.php/Libata-tj-stable
is down).  You may have some luck googling around for those.

2.6.21 is over two years old, so your best bet would be to upgrade to
a more recent version, or, if you're stuck with some distribution
kernel, talk to your vendor for support.

-jim
