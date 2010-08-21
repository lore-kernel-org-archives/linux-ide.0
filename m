From: Cyril Hrubis <metan-+ZI9xUNit7I@public.gmane.org>
Subject: Re: zaurus pata_pcmcia corrupted filesystem
Date: Sat, 21 Aug 2010 11:51:37 +0200
Message-ID: <20100821095137.GA22301@atrey.karlin.mff.cuni.cz>
References: <20100811144410.GA12029@atrey.karlin.mff.cuni.cz>
	<20100814094353.GB926@boggieman.bredbandsbolaget.se>
	<1281782580.6707.1.camel@utx.lan>
	<20100814113937.GB9346@atrey.karlin.mff.cuni.cz>
	<1281795351.15157.3.camel@utx.lan>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1281795351.15157.3.camel-T9yq2y+nUN8@public.gmane.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Stanislav Brabec <utx-ZsETY1VsSgLrBKCeMvbIDA@public.gmane.org>
Cc: thommycheck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arminlitzel-S0/GAf8tV78@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kristoffer Ericson <kristoffer.ericson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi!
> > These seems to be different, at least it newer occured so often to me. Now
> > installing debian packages often fails because it cannot remove temporary
> > files, the filesystem worked reasonably good before.
> > 
> > The usecase is to unpack archive with a lot rather small files somewhere deeper
> > to the filesystem tree. Eg. installing gtk2-devel failed miserably when trying
> > to move all the header files from *.h.dpkg-new to *.h, this works rather good
> > with old driver.
> 
> Well, I remember opkg crashes while installing emacs (many small files)
> and file system corruption as well. Both with kernel 2.6.26.
>

The main difference is that now it's 100% reproducible and I've never seen
corruption bad enough so I could not delete files without doing fsck first.

Here is pseudo output from fsck on ext3 filesystem after these problems
appeared:

Pass 2:

Bunch of these:

Invalid HTREE directory inode $NUMBER
$PATH/$FILE
Clear HTree index<y>?

and these:

Problem in HTree directory inode $NUMBER: block #$NR has bad max hash

Pass 3:

Bunch of:

Entry '$FILE in $PATH ($NUMBER) has a non-unique filename.
Rename to $FILE~0<y>?

Happily the files/directories affected was only the recently written from the
kernel from marex tree.  I haven't seen file content to be corrupted (that
doesn't mean there weren't any corruptions) but it seems they are not so likely
as directory tree corruption.

-- 
metan
