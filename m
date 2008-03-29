From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,
	SCAN]_HWIF ioctls
Date: Sat, 29 Mar 2008 17:10:54 +0100
Message-ID: <200803291710.54843.bzolnier@gmail.com>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<47EBDBAA.2020308@ru.mvista.com> <47ED439C.9030400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <47ED439C.9030400@rtr.ca>
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
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Friday 28 March 2008, Mark Lord wrote:
> Sergei Shtylyov wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > 
> >> hdparm explicitely marks HDIO_[UNREGISTER,SCAN]_HWIF ioctls as DANGEROUS
> >> and given the number of bugs we can assume that there are no real users:
> ..
> 
> There is the odd user of these, actually.
> 
> But the most recent to email me (a few weeks ago),
> reported that the SCAN function was no longer working on his kernel.
> 
> I'll remove the -R and -U flags completely from hdparm-8.7.

This will be quite helpful, thanks!

Bart
