From: Stanislav Brabec <utx@penguin.cz>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 14 Aug 2010 12:43:00 +0200
Message-ID: <1281782580.6707.1.camel@utx.lan>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
	 <20100814094353.GB926@boggieman.bredbandsbolaget.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100814094353.GB926@boggieman.bredbandsbolaget.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Cyril Hrubis <metan@ucw.cz>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, zaurus-devel@lists.linuxtogo.org, Marek Vasut <marek.vasut@gmail.com>
List-Id: linux-ide@vger.kernel.org

Kristoffer Ericson wrote: 
> On Wed, Aug 11, 2010 at 04:44:11PM +0200, Cyril Hrubis wrote:
> > Hi!
> > Marek Vasut ported deprecated zaurus pcmcia disk driver to the pata_pcmcia
> > interface, sources are here:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/marex/pxa-linux-2.6.git;a=shortlog;h=refs/heads/zaurus-haxing
> > 
> > Everythig seems to be fine at the first look but sometimes the filesystem gets
> > unconsistent. Typical example is extracting tar archive with big number of
> > files and directories (I used ltp-full archive from
> > http://www.sf.net/projects/ltp/). After doing that, some files or directories
> > are present in the filesystem, eg. you can see them in directory listing but
> > open or fstat returns ENOENT.
> > 
> > Extracting to SD card seems to work without any problems.
> > 
> > Anybody has idea what went wrong?
> 
> What kind of number of files (in tar archive) are we talking about in round
> figures? Does the files it affect differ in size (large fail, small doesnt)..?
> Its hard to say without having more data (as always).

These mysterious failures were discussed several times before in
zaurus-devel[1][2][3][4][5][6]. We suspected PCMCIA code, RAM errors or
bad voltage.

Typical reproducers:

git status on kernel tree (false result)
copy files from CF to SD or USB (errors in files)
gcc while using CF WLAN or CF Bluetooth (segfault)

It happened in all kernels at least since 2.6.26, but probably in all
2.6 kernels.

[1] http://lists.linuxtogo.org/pipermail/zaurus-devel/2010-June/000306.html
[2] http://lists.linuxtogo.org/pipermail/zaurus-devel/2010-June/000305.html
[3] http://lists.linuxtogo.org/pipermail/zaurus-devel/2010-April/000242.html
[4] http://lists.linuxtogo.org/pipermail/zaurus-devel/2010-March/000217.html
[5] http://lists.linuxtogo.org/pipermail/zaurus-devel/2010-March/000227.html

-- 
________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
