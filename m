From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 05:33:00 -0400
Message-ID: <469C8CCC.80009@garzik.org>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
	<20070717090219.GA24991@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
In-Reply-To: <20070717090219.GA24991@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linuxsh-dev@lists.sourceforge.net, linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Paul Mundt wrote:
> On Tue, Jul 17, 2007 at 05:42:52PM +0900, Magnus Damm wrote:
>> pata_platform: Fix NULL pointer dereference
>>
>> The platform-specific structures may leave pdev->dev.platform_data as NULL.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> Looks like the change that broke this came in the libata merge, more
> specifically this change:
> 
> commit 5f45bc50976ee1f408f7171af155aec646655a37
> Author: Sonic Zhang <sonic.adi@gmail.com>
> Date:   Fri Jun 15 17:45:49 2007 +0800
> 
>     Add irq_flags to struct pata_platform_info
> 
>     On some embedded platforms, such as blackfin, the gpio interrupt for
>     IDE interface is designed to be triggered with high voltage. The gpio
>     port should be configured properly by set_irq_type() when register
>     the irq. This patch enable the generic pata platform driver to
>     accept platform irq flags data.
> 
>     Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> It would be great if libata people could actually be bothered to CC driver
> authors on driver changes so that way these things don't get completely broken
> in mainline when simple testing on the platforms that actually _rely_ on this
> driver would have shown that this was broken.
> 
> I don't intend to poll the various libata branches on the off chance I'll find
> something that's hosed my platforms, and I don't think it's an unreasonable
> expectation to at least have to see the patch and sign off on it before it gets
> merged. Every other subsystem works this way, I wonder why libata feels that
> it's special.
> 
> This is also not the first time changes to pata_platform have caused fallout,
> without finding out about it until after the changes were already merged.

The patch lived for weeks in -mm along with tons of other git trees 
Andrew pulls.  If you want a single point to watch for upcoming stuff, 
test the -mm trees.  It's a key part of the development process:  I 
merge a patch, -mm tree pulls my tree and others, people test and 
complain and give feedback, ...

With embedded stuff its tough to judge whether people are knowledgeable 
about the impact of the change, and sometimes I judge wrongly.  My 
apologies.

What is your suggestion for moving linux-2.6.git forward?

	Jeff



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
