From: Aditya Prayoga <aditya@kobol.io>
Subject: Re: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x
Date: Wed, 26 Sep 2018 13:05:49 +0700
Message-ID: <CAFTRUBdqz8fQN--KQ36LQm_EJpOvZ2723oDRyEn+_HMM5YK5CA@mail.gmail.com>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-3-git-send-email-aditya@kobol.io> <20180920072635.GB20392@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920072635.GB20392@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: linux-ide@vger.kernel.org, linux-leds@vger.kernel.org, jason@lakedaemon.net, Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux@armlinux.org.uk, axboe@kernel.dk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com, Daniel Golle <daniel@makrotopia.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 20, 2018 at 2:26 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-09-19 11:45:30, Aditya Prayoga wrote:
> > Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
> > used in kernel configuration.
>
> Should that be hidden symbol and should that be architecture specific?
>

The intention was to minimize the risk of the ledtrig code being
included by accident. The
code itself does not have architecture specific instruction

> For a notebook, I may want scrolllock LED to indicate ATA activity
> (because I'm using USB keyboard and can't see the disk led).
>
> Hmm. And while at it... it would be nice to have option to watch all
> ATA ports combined, as well.

but there is disk-activity trigger for that purpose.

Aditya

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
