From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Tue, 12 May 2009 08:31:44 +1000
Message-ID: <1242081104.304.12.camel@pasglop>
References: <200905062009.28087.markos@codex.gr> <4A086A76.3090008@garzik.org>
	<20090511194410.46641214@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090511194410.46641214@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 2009-05-11 at 19:44 +0100, Alan Cox wrote:
> > Ideally the DMI subsystem should be provided wrappers for platforms 
> > without DMI, rendering patches like this unnecessary.
> 
> Interesting question - is the PPC OpenFirmware machine information
> mappable onto the DMI space ? or the various static bits of name
> information in the various ARM and the like machine descriptions.
> 
> If not which bits are similar enough we could replace dmi at the high
> level with an abstract interface for system/vendor/... that was ?

The one thing we could try to map would be the device-tree "compatible"
property which would contain vendor,system tuples from more specific to
more generic with which the machine is compatible with.

Of course I would argue the other way around and create a device-tree
from the DMI data :-)

Cheers,
Ben.
