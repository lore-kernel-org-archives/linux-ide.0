From: Jim Paris <jim@jtan.com>
Subject: Re: sata_sil24 stability and performance
Date: Mon, 18 Feb 2008 23:36:59 -0500
Message-ID: <20080219043659.GA11936@jim.sh>
References: <20080219020916.GA29902@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:44603 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbYBSEhG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 23:37:06 -0500
Content-Disposition: inline
In-Reply-To: <20080219020916.GA29902@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: linux-ide@vger.kernel.org

Denys Dmytriyenko wrote:
> I've been following this list for several months now trying to spot a similar
> issue or to gain knowledge to resolve mine.
..
> I'm running a fileserver with array of 10 disks (8 Seagate 500GB 7200.9 and
> 7200.10 plus 2 Maxtors)
..
> Power supply was
> originally 550 watt Enermax (should be enough power, according to a wattmeter),
> but to be sure was replaced to 750 watt Coolermaster.

Hi,

As you may have noticed on this list, power supplies are very
frequently a problem.  Just taking what you said, a ST3500630AS
7200.10 disk requires up to 2.8A peak on the +12V line, which is 28A
total for 10 disks.  The Coolermaster Real Power Pro 750 has three
separate 12V rails and each can only go up to 19A.  So that might
already be the answer, depending on how the rails match up with your
wiring.

I suggest hooking up a couple of the disks to your old power supply
and powering them up separately [1].  If you don't see any problems on
those disks then it was likely power related.

-jim

[1] http://modtown.co.uk/mt/article2.php?id=psumod
