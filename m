From: Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
Date: Thu, 20 Sep 2018 10:24:29 +0200
Message-ID: <20180920082425.GB20006@makrotopia.org>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
 <20180920072354.GA20392@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180920072354.GA20392@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@bootlin.com>, Aditya Prayoga <aditya@kobol.io>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi!

On Thu, Sep 20, 2018 at 09:23:54AM +0200, Pavel Machek wrote:
> Hi!
> 
> > +#ifdef CONFIG_ATA_LEDS
> > +	/* register LED triggers for all ports */
> > +	for (i = 0; i < host->n_ports; i++) {
> > +		if (unlikely(!host->ports[i]->ledtrig))
> > +			continue;
> > +
> > +		snprintf(host->ports[i]->ledtrig_name,
> > +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> > +			host->ports[i]->print_id);
> 
> > +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> > +
> > +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> > +			kfree(host->ports[i]->ledtrig);
> > +			host->ports[i]->ledtrig = NULL;
> > +		}
> > +	}
> > +#endif
> 
> No, we don't want you to register multiple triggers. We want one
> trigger, than has parameter "which port to watch". (Number of triggers
> is limited as by sysfs limitations).

Back then I implemented it that way to be able to define the
default trigger for each LED in device tree and "trigger-sources"
didn't exist yet (it was introduced for USB ports and isn't yet used
for anything other than that)
However, the problem till today is also that ATA ports are often not
individual device-tree objects we can refer to, see for example
marvell,armada-370-sata which appears as one opaque controller. Ie.
all SATA drivers have to be converted to expose individual ports on
device-tree before the trigger-sources approach can be applied...


> 
> Otherwise yes, ata trigger makes sense.
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
