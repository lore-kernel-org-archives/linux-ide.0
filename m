From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Wed, 18 Jul 2007 18:32:02 +0900
Message-ID: <aec7e5c30707180232ke9c06baue37d33969257c2e8@mail.gmail.com>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
	<20070717090219.GA24991@linux-sh.org> <469C8CCC.80009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
In-Reply-To: <469C8CCC.80009@garzik.org>
Content-Disposition: inline
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
Cc: linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

On 7/17/07, Jeff Garzik <jeff@garzik.org> wrote:
> Paul Mundt wrote:
> > On Tue, Jul 17, 2007 at 05:42:52PM +0900, Magnus Damm wrote:
> >> pata_platform: Fix NULL pointer dereference
> >>
> >> The platform-specific structures may leave pdev->dev.platform_data as NULL.
> >>
> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>
> What is your suggestion for moving linux-2.6.git forward?

This fix solves the problem for me and Paul seems to be happy with it as well.
Jeff, can you please pick up this patch so we can unbreak things for rc1?

Thanks!

/ magnus

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
