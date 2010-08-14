From: Cyril Hrubis <metan@ucw.cz>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 14 Aug 2010 18:48:31 +0200
Message-ID: <20100814164830.GA23802@atrey.karlin.mff.cuni.cz>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz> <201008140616.04034.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:57640 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757096Ab0HNQsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Aug 2010 12:48:32 -0400
Content-Disposition: inline
In-Reply-To: <201008140616.04034.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz, zaurus-devel@lists.linuxtogo.org

Hi!
> > Marek Vasut ported deprecated zaurus pcmcia disk driver to the pata_pcmcia
> > interface, sources are here:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/marex/pxa-linux-2.6.git;a=shortlo
> > g;h=refs/heads/zaurus-haxing
> > 
> > Everythig seems to be fine at the first look but sometimes the filesystem
> > gets unconsistent. Typical example is extracting tar archive with big
> > number of files and directories (I used ltp-full archive from
> > http://www.sf.net/projects/ltp/). After doing that, some files or
> > directories are present in the filesystem, eg. you can see them in
> > directory listing but open or fstat returns ENOENT.
> > 
> > Extracting to SD card seems to work without any problems.
> > 
> > Anybody has idea what went wrong?
> 
> I use the pcmcia on a few devices and was unable to replicate it (and I use git 
> and do some heavy compiling on them too). I'll do some further testing.
> 
> Cyril, do you have the PCMCIA timing fix for PXA applied?

Well git log says so:

...
    pxa2xx/cpufreq: Fix PCMCIA frequency scaling
    
    The MCxx values must be based off memory clock, not CPU core clock.
    
    This also fixes the bug where on some machines the LCD went crazy while using
    PCMCIA.
    
...


At least it's your tree that I've been testing ;).

-- 
Cyril Hrubis
