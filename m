From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
Date: Fri, 14 Jul 2017 15:55:26 +0300
Message-ID: <20170714125525.kjemhcn4poon6r3i@mwanda>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
 <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: devel@driverdev.osuosl.org, Hans Verkuil <hverkuil@xs4all.nl>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daeseok Youn <daeseok.youn@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, adi-buildroot-devel@lists.sourceforge.net, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Ah...  I see why it's complaining about these ones in particular...

I don't agree with it as a static analysis dev, and I don't like the
changes too much.  But since it's only generating a hand full of
warnings then I don't care.

regards,
dan carpenter
