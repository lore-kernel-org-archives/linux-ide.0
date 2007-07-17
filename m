From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 06:24:53 -0400
Message-ID: <469C98F5.50101@garzik.org>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
	<20070717090219.GA24991@linux-sh.org> <469C8CCC.80009@garzik.org>
	<20070717094728.GA25527@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
In-Reply-To: <20070717094728.GA25527@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

Paul Mundt wrote:
> On Tue, Jul 17, 2007 at 05:33:00AM -0400, Jeff Garzik wrote:
>> Paul Mundt wrote:
>>> It would be great if libata people could actually be bothered to CC
>>> driver authors on driver changes so that way these things don't get
>>> completely broken in mainline when simple testing on the platforms
>>> that actually _rely_ on this driver would have shown that this was
>>> broken.
>> The patch lived for weeks in -mm along with tons of other git trees 
>> Andrew pulls.  If you want a single point to watch for upcoming stuff, 
>> test the -mm trees.  It's a key part of the development process:  I 
>> merge a patch, -mm tree pulls my tree and others, people test and 
>> complain and give feedback, ...
>>
> A key part of the development process is making sure that driver authors
> are aware of the changes being made to their drivers, so they're able to
> ACK/NACK or at least point out something that's obviously wrong. I test
> -mm when time permits, and this happened to slip through. If I had
> actually been CC'ed on it, it would not have.
> 
> Your entire process is fundamentally flawed if you're merging the patch
> first and expecting people to only find out if it's broken after the
> fact. In the best case it leaves -mm broken for a single release, and in
> the other case, it happens to make its way to mainline before anyone
> notices.

It's just reality that there are never enough people to verify every 
patch before it goes in.  We just support way too much hardware for that 
to be remotely feasible.  Sure we -try- to keep the driver maintainer 
CC'd, but alas we are human.

Your thinking is flawed if you think I'm going to hold up every patch 
until it's verified on each of 63 ATA controller drivers, when I make a 
core change, for example.  Not scalable.  We scale in another way:

We have the biggest test lab in the world -- the Internet -- and a 
development process staged so that testing and development occur in 
parallel.  This here is actually an example of the process working: 
despite my forgetting to CC you, the problem was caught long before it 
made it into any release kernel.

	Jeff



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
