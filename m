From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH] ahci: Changing two module params with static and
 __read_mostly
Date: Wed, 18 Sep 2013 02:52:00 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A01B2CAC5@SHSMSX101.ccr.corp.intel.com>
References: <1379436518.26153.31.camel@cliu38-desktop-build>
 <1379435064.2012.8.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43365 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab3IRCwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Sep 2013 22:52:05 -0400
In-Reply-To: <1379435064.2012.8.camel@joe-AO722>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Wednesday, September 18, 2013 12:24 AM
> To: Liu, Chuansheng
> Cc: tj@kernel.org; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ahci: Changing two module params with static and
> __read_mostly
> 
> On Wed, 2013-09-18 at 00:48 +0800, Chuansheng Liu wrote:
> > Here module parameters ahci_em_messages and devslp_idle_timeout can
> > be set as static and __read_mostly.
> >
> > Signed-off-by: Liu, Chuansheng <chuansheng.liu@intel.com>
> > ---
> >  drivers/ata/libahci.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> []
> > @@ -189,14 +189,15 @@ struct ata_port_operations
> ahci_pmp_retry_srst_ops = {
> >  };
> >  EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
> >
> > -int ahci_em_messages = 1;
> > +static int ahci_em_messages __read_mostly = 1;
> 
> This one could also be converted to
> static bool ahci_em_messages __read_mostly = true;
> 
Thanks, will update one new patch.
