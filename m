From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
Date: Fri, 14 Jul 2017 15:05:12 +0300
Message-ID: <20170714120512.ioe67nnloqivtbr7@mwanda>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170714093938.1469319-1-arnd@arndb.de>
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
Cc: devel@driverdev.osuosl.org, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daeseok Youn <daeseok.youn@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, adi-buildroot-devel@lists.sourceforge.net, Hans Verkuil <hverkuil@xs4all.nl>, linux-ide@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Changing:

- if (!frob()) {
+ if (frob() == 0) {

is a totally pointless change.  They're both bad, because they're doing
success testing instead of failure testing, but probably the second one
is slightly worse.

This warning seems dumb.  I can't imagine it has even a 10% success rate
at finding real bugs.  Just disable it.

Changing the code to propagate error codes, is the right thing of course
so long as it doesn't introduce bugs.

regards,
dan carpenter
