From: Stanislav Brabec <utx@penguin.cz>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 14 Aug 2010 16:15:51 +0200
Message-ID: <1281795351.15157.3.camel@utx.lan>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
	 <20100814094353.GB926@boggieman.bredbandsbolaget.se>
	 <1281782580.6707.1.camel@utx.lan>
	 <20100814113937.GB9346@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.penguin.cz ([84.21.108.25]:47549 "EHLO ns.penguin.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756628Ab0HNOP4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Aug 2010 10:15:56 -0400
In-Reply-To: <20100814113937.GB9346@atrey.karlin.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyril Hrubis <metan@ucw.cz>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu, arminlitzel@web.de, thommycheck@gmail.com, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, zaurus-devel@lists.linuxtogo.org, Marek Vasut <marek.vasut@gmail.com>

Cyril Hrubis wrote:

> These seems to be different, at least it newer occured so often to me. Now
> installing debian packages often fails because it cannot remove temporary
> files, the filesystem worked reasonably good before.
> 
> The usecase is to unpack archive with a lot rather small files somewhere deeper
> to the filesystem tree. Eg. installing gtk2-devel failed miserably when trying
> to move all the header files from *.h.dpkg-new to *.h, this works rather good
> with old driver.

Well, I remember opkg crashes while installing emacs (many small files)
and file system corruption as well. Both with kernel 2.6.26.

-- 

________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus

