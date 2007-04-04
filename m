From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Date: Wed, 4 Apr 2007 20:42:14 +0200
Message-ID: <200704042042.15108.bzolnier@gmail.com>
References: <20070404111635.GA1855@aepfle.de>
	<200704042010.50088.bzolnier@gmail.com>
	<20070404181138.GA6050@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20070404181138.GA6050@aepfle.de>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Wednesday 04 April 2007, Olaf Hering wrote:
> On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:
> 
> > ?
> 
> You are right, I did not test the ide driver again. pata_via works with
> the change. 
> I will test the ide driver tomorrow.

Thanks.

There might be also the another issue here - the chipset claims fully native
mode (prog-if 8f - taken from your previous mail) so driver takes IRQ value
from dev->irq (which your patch fixes to be 14 instead of 20 if I'm reading
it correctly) but in reality chipset seems to be still using legacy IRQs
(14 for the primary port and 15 for the secondary one).  What IRQ value is
reported by the libata for the secondary port?  Does the second port work?

Bart
