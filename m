From: Cyril Hrubis <metan@ucw.cz>
Subject: zaurus pata_pcmcia corrupted filesystem
Date: Wed, 11 Aug 2010 16:44:11 +0200
Message-ID: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:55256 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753179Ab0HKOoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Aug 2010 10:44:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz, zaurus-devel@lists.linuxtogo.org, Marek Vasut <marek.vasut@gmail.com>

Hi!
Marek Vasut ported deprecated zaurus pcmcia disk driver to the pata_pcmcia
interface, sources are here:

http://git.kernel.org/?p=linux/kernel/git/marex/pxa-linux-2.6.git;a=shortlog;h=refs/heads/zaurus-haxing

Everythig seems to be fine at the first look but sometimes the filesystem gets
unconsistent. Typical example is extracting tar archive with big number of
files and directories (I used ltp-full archive from
http://www.sf.net/projects/ltp/). After doing that, some files or directories
are present in the filesystem, eg. you can see them in directory listing but
open or fstat returns ENOENT.

Extracting to SD card seems to work without any problems.

Anybody has idea what went wrong?

-- 
Cyril Hrubis
metan@ucw.cz
