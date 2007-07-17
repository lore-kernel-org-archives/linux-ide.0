From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 18:47:28 +0900
Message-ID: <20070717094728.GA25527@linux-sh.org>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
	<20070717090219.GA24991@linux-sh.org> <469C8CCC.80009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <469C8CCC.80009@garzik.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 17, 2007 at 05:33:00AM -0400, Jeff Garzik wrote:
> Paul Mundt wrote:
> >It would be great if libata people could actually be bothered to CC
> >driver authors on driver changes so that way these things don't get
> >completely broken in mainline when simple testing on the platforms
> >that actually _rely_ on this driver would have shown that this was
> >broken.
> 
> The patch lived for weeks in -mm along with tons of other git trees 
> Andrew pulls.  If you want a single point to watch for upcoming stuff, 
> test the -mm trees.  It's a key part of the development process:  I 
> merge a patch, -mm tree pulls my tree and others, people test and 
> complain and give feedback, ...
> 
A key part of the development process is making sure that driver authors
are aware of the changes being made to their drivers, so they're able to
ACK/NACK or at least point out something that's obviously wrong. I test
-mm when time permits, and this happened to slip through. If I had
actually been CC'ed on it, it would not have.

Your entire process is fundamentally flawed if you're merging the patch
first and expecting people to only find out if it's broken after the
fact. In the best case it leaves -mm broken for a single release, and in
the other case, it happens to make its way to mainline before anyone
notices.

> With embedded stuff its tough to judge whether people are knowledgeable 
> about the impact of the change, and sometimes I judge wrongly.  My 
> apologies.
> 
Another reason to make sure the authors are CC'ed. I really don't see why
this is so difficult for you, _everyone_ else manages to do this
properly, and shis sort of case illustrates _exactly_ why.

> What is your suggestion for moving linux-2.6.git forward?
> 
The patch from Magnus is fine with me for fixing this particular problem,
so at least getting that merged quickly will get the sh and ppc platforms
fixed again.

To avoid having this happen again in the future, I'd appreciate being
CC'ed on things that impact pata_platform pre-merge, and again, I don't
see this as an extraordinarly unreasonable request. If you can't be
bothered doing that, then just stop applying pata_platform patches, and
I'll merge them myself.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
