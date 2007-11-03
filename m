From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Suspend to ram regression (2.6.24-rc1-git)
Date: Sat, 3 Nov 2007 10:02:23 -0700
Message-ID: <20071103100223.48831355@laptopd505.fenrus.org>
References: <20071031201308.GK11514@kernel.dk>
	<20071101084145.GA5037@kernel.dk>
	<20071102163708.15304989.kristen.c.accardi@intel.com>
	<20071103062304.GA10428@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:52729 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbXKCRCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 13:02:44 -0400
In-Reply-To: <20071103062304.GA10428@thunk.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org

On Sat, 3 Nov 2007 02:23:04 -0400
Theodore Tso <tytso@mit.edu> wrote:

> Yep, this fixes suspend/resume on my X61 thinkpad.  Interestingly I'm
> not seeing any power savings with ALPM set to min_power, at least not
> compared to what I get after suspend and resuming (which mysteriously
> cause the power utilization of my laptop to drop by a watt --- maybe
> that is engaging ALPM as part of the suspend process?  I dunno).


ALPM seems to help only if your disk is idle for 2 seconds or more;
unfortunately several standard linux desktops have the disk spin up all
the time via all kinds of things.... there's some "standard guilty"
ones if you're interested in chasing this down..
