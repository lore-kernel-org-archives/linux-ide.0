From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
Date: Tue, 01 Dec 2009 21:53:39 +1100
Message-ID: <1259664819.2076.356.camel@pasglop>
References: <20091201070834.6A840B7B63@ozlabs.org>
	<19220.62569.492975.964154@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <19220.62569.492975.964154@pilspetsen.it.uu.se>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 11:48 +0100, Mikael Pettersson wrote:
> Thanks for reviving pata_macio.
> 
> Does the new version work with yaboot? (the previous one didn't)

Well, yaboot itself should have no problem. However, the ybin script
that automagically finds the right OF path might indeed still be busted,
it will have to be updated I'm afraid as it's more/less hard coded to
know about IDE gunk

I'll have a look. The new yaboot maintainer (Tony Breeds) happens to sit
2 cubicles away from me at work so it shouldn't be a huge deal.

Thanks for reminding me tho !

Cheers,
Ben.
