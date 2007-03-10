From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Again problems with PDC20268 and vol_id
Date: Sat, 10 Mar 2007 16:52:09 +0100
Message-ID: <200703101652.09442.bzolnier@gmail.com>
References: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org>
	<20070309190856.c86efd73.vsu@altlinux.ru>
	<200703101057.32631.guido@jcwodan.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200703101057.32631.guido@jcwodan.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-hotplug-devel-bounces@lists.sourceforge.net
Errors-To: linux-hotplug-devel-bounces@lists.sourceforge.net
To: Guido Diepen <guido@jcwodan.nl>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, Sergey Vlasov <vsu@altlinux.ru>
List-Id: linux-ide@vger.kernel.org


[ added Jens to cc: ]

Hi,

On Saturday 10 March 2007, Guido Diepen wrote:
> Hi Sergey,
> 
> > Is the partition table correct?  Maybe the partition extends beyond
> > the end of physical disk for some reason, and when the kernel tries to
> > access last blocks of the partition, it actually tries to read sectors
> > beyond the actual drive capacity, which fails and exposes broken error
> > handling in the Promise IDE driver.
> >
> > I have added the linux-ide mailing list to Cc: - problems related to
> > IDE/ATA drivers (both old IDE, which you are using currently, and
> > newer libata) should be discussed there.
> 
> Last night I copied all data on the /dev/hdg2 partition to other partitions, 
> removed the /dev/hdg2 partition and recreated it. Currently everything works 
> flawless !!!

Thanks for testing this (and reporting the bug in the first place).
Also big thanks to Sergey for digging out the source of the issue.

> Apparently there is a bug in the promise IDE pdc202xx_new.c driver :)

IDE error recovery code needs improvements (people are working at it)
but there is no wonder that it failed miserably first in DMA mode and later
during PIO retries - it just couldn't read the sector which doesn't exist.
Probably the final steps of error recovery procedure were unsuccessful because
it is using the older method for putting the drive into the "good" idle state
which confuses newer disks (there is a patch - to be merged - from Suleiman
Souhlal addressing this).

However it seems that the root source of the problem was that IDE subsystem
got the request for sector outside the valid sector range and it should _never_
happen for requests originating from the block layer (a lot of code - not only
in the IDE subsystem - assumes this)...

Thanks,
Bart

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
