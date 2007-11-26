From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Mon, 26 Nov 2007 03:21:26 +0300
Message-ID: <20071126002126.GA20043@zarina>
References: <20071123175229.GA27143@localhost.localdomain>
	<200711242150.09812.arnd@arndb.de>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <200711242150.09812.arnd@arndb.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 24, 2007 at 09:50:07PM +0100, Arnd Bergmann wrote:
> On Friday 23 November 2007, Anton Vorontsov wrote:
> > Here is the PATA Platform driver using OF infrastructure.
> > 
> > Mostly it's just a wrapper around a bit modified pata_platform
> > driver.
> 
> Thanks a lot for doing this. Patches 2/3 are what I tried to get
> people to do for some time now but was too lazy to do myself.
> 
> As a further thought, do the drivers now still need to be
> pata specific, or should the OF part be called ata_of_platform
> instead and also be used for sata devices?

Ugh, I don't know much about sata, it should act just as a pata
in the very basic usage, IIRC. So it's worth trying, but I don't
have any platform satas to try... :-/

Hereby, I'd rather stick with pata name, as it's never too late
to simply rename things later.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
