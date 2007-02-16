From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
	CD drives
Date: Sat, 17 Feb 2007 08:41:19 +1100
Message-ID: <1171662079.5644.77.camel@localhost.localdomain>
References: <20070210203512.GA25586@aepfle.de>
	<20070216092046.GA2572@aepfle.de> <45D5B720.4010308@ru.mvista.com>
	<200702161553.54550.bzolnier@gmail.com>
	<45D5C5CC.9070406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <45D5C5CC.9070406@ru.mvista.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mackeras <paulus@samba.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 2007-02-16 at 17:55 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
> >>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
> >>pata_sl82c105 (indeed better version of sl82c105 driver).
> 
> > I was under the impression that with your fixes these drivers
> > (sl82c105 and pata_sl82c105) are functionally equivalent.
> 
>     They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
> sl82c105 still supports only MWDMA2.

BTW, the "old ide" sl82c105 currently upstream produces warnings on 64
bits platforms about conversion between int and pointers of different
sizes. I didn't have time to look closely yesterday though, could be
harmless.

Ben.
