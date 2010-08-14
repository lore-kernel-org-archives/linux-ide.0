From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 14 Aug 2010 11:43:53 +0200
Message-ID: <20100814094353.GB926@boggieman.bredbandsbolaget.se>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
Reply-To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50108 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab0HNJlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Aug 2010 05:41:32 -0400
Content-Disposition: inline
In-Reply-To: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyril Hrubis <metan@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz, zaurus-devel@lists.linuxtogo.org, Marek Vasut <marek.vasut@gmail.com>

On Wed, Aug 11, 2010 at 04:44:11PM +0200, Cyril Hrubis wrote:
> Hi!
> Marek Vasut ported deprecated zaurus pcmcia disk driver to the pata_pcmcia
> interface, sources are here:
> 
> http://git.kernel.org/?p=linux/kernel/git/marex/pxa-linux-2.6.git;a=shortlog;h=refs/heads/zaurus-haxing
> 
> Everythig seems to be fine at the first look but sometimes the filesystem gets
> unconsistent. Typical example is extracting tar archive with big number of
> files and directories (I used ltp-full archive from
> http://www.sf.net/projects/ltp/). After doing that, some files or directories
> are present in the filesystem, eg. you can see them in directory listing but
> open or fstat returns ENOENT.
> 
> Extracting to SD card seems to work without any problems.
> 
> Anybody has idea what went wrong?

What kind of number of files (in tar archive) are we talking about in round
figures? Does the files it affect differ in size (large fail, small doesnt)..?
Its hard to say without having more data (as always).

> 
> -- 
> Cyril Hrubis
> metan@ucw.cz
