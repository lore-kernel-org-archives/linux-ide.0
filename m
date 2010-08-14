From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 14 Aug 2010 06:16:03 +0200
Message-ID: <201008140616.04034.marek.vasut@gmail.com>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49487 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0HNEQf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Aug 2010 00:16:35 -0400
In-Reply-To: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyril Hrubis <metan@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz, zaurus-devel@lists.linuxtogo.org

Dne St 11. srpna 2010 16:44:11 Cyril Hrubis napsal(a):
> Hi!
> Marek Vasut ported deprecated zaurus pcmcia disk driver to the pata_pcmcia
> interface, sources are here:
> 
> http://git.kernel.org/?p=linux/kernel/git/marex/pxa-linux-2.6.git;a=shortlo
> g;h=refs/heads/zaurus-haxing
> 
> Everythig seems to be fine at the first look but sometimes the filesystem
> gets unconsistent. Typical example is extracting tar archive with big
> number of files and directories (I used ltp-full archive from
> http://www.sf.net/projects/ltp/). After doing that, some files or
> directories are present in the filesystem, eg. you can see them in
> directory listing but open or fstat returns ENOENT.
> 
> Extracting to SD card seems to work without any problems.
> 
> Anybody has idea what went wrong?

I use the pcmcia on a few devices and was unable to replicate it (and I use git 
and do some heavy compiling on them too). I'll do some further testing.

Cyril, do you have the PCMCIA timing fix for PXA applied?
