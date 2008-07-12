From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk
	Extreme III 8GB
Date: Sat, 12 Jul 2008 11:39:16 +0900
Message-ID: <20080712113916.fb69df6b.komurojun-mbn@nifty.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>
	<20080528222740.GB20893@isilmar.linta.de>
	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>
	<20080607223716.7d142072.komurojun-mbn@nifty.com>
	<20080611072029.GB28692@comet.dominikbrodowski.net>
	<20080614120055.ad8fbee0.komurojun-mbn@nifty.com>
	<48537149.4040102@garzik.org>
	<20080614213612.96873c25.komurojun-mbn@nifty.com>
	<4855D8E2.10409@gmail.com>
	<20080616221145.e3b069b9.komurojun-mbn@nifty.com>
	<485669A0.6000404@gmail.com>
	<20080617212345.c452d8c5.komurojun-mbn@nifty.com>
	<20080706103752.13935ffd.komurojun-mbn@nifty.com>
	<4870D46C.7000604@gmail.com>
	<20080707214253.2406f81a.komurojun-mbn@nifty.com>
	<48743A1A.2010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <48743A1A.2010304@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pcmcia <linux-pcmcia@lists.infradead.org>, linux-kernel@vger.kernel.org, Brodowski <linux@dominikbrodowski.net>, rjw@sisk.pl, linux-ide@vger.kernel.org, Dominik, Kristoffer Ericson <kristoffer.ericson@gmail.com>, jgarzik@redhat.com
List-Id: linux-ide@vger.kernel.org


Hello,

> Ah... super strange.  Can you please try to swap memory sticks around
> and see whether anything changes to rule out bad memory?  

I tried the pata_pcmcia on 3(three) PC.but the result is same.
So I think the memory is good.

> Another
> possibility is DMA corrupting the memory and printk makes the timing
> different and dodges the bullet.  Does putting msleep(100) in the
> pata_pcmcia init_one make any difference?

I tried the msleep , but it still does not work.

By the way,
If I delete the pata_pcmcia.ko from /lib/modules/...
and insert the ata pcmcia card,
only /sys/bus/pcmcia/devices/0.0 exist.

But if I install the pata_pcmcia.ko,
/sys/bus/pcmcia/devices/0.0 and
/sys/bus/pcmcia/devices/0.1 exist.

Maybe the sysfs or something like that 
is the problem.

Best Regards
Komuro
