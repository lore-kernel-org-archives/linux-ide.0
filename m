From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch 4/4] ide: Break ide_lock -- remove ide_lock  from piix driver
Date: Wed, 7 Sep 2005 10:50:19 -0700
Message-ID: <20050907175019.GA3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050906234429.GE3642@localhost.localdomain> <1126112783.8928.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from serv01.siteground.net ([70.85.91.68]:15562 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751259AbVIGRuZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Sep 2005 13:50:25 -0400
Content-Disposition: inline
In-Reply-To: <1126112783.8928.14.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>

On Wed, Sep 07, 2005 at 06:06:23PM +0100, Alan Cox wrote:
> On Maw, 2005-09-06 at 16:44 -0700, Ravikiran G Thirumalai wrote:
> > Patch to convert piix driver to use per-driver/hwgroup lock and kill
> > ide_lock.  In the case of piix, hwgroup->lock should be sufficient.
> 
> PIIX requires that both channels are quiescent when retuning in some
> cases. It wasn't totally safe before, its now totally broken. Start by

Then the change to piix controller in my patchset is bad, How about changing
the ide_lock to per-driver lock in this case?  Locking for rest of the
controllers in the system is left equivalent to what ide_lock did earlier..


> fixing the IDE layer locking properly (or forward porting my patches and
> then fixing them for all the refcounting changes and other stuff done
> since).

Can you please point me to the patchset...

Thanks,
Kiran
