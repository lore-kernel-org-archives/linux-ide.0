From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Fri, 11 Sep 2015 05:27:25 +0000
Message-ID: <DM2PR03MB5746E6637A2BC5081EC5428FA500@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
 <20150909140130.GB22909@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bbn0107.outbound.protection.outlook.com ([157.56.111.107]:39840
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750819AbbIKF1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2015 01:27:35 -0400
In-Reply-To: <20150909140130.GB22909@mtj.duckdns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Tejun,

Could you please take the version 1 patch?
The version 2 patch can't address these warnings, and the version 1 can definitely remove them.
In this case, that would cause any hidden bugs, so no worries.

Regards,
Yuantian

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
> Sent: Wednesday, September 09, 2015 10:02 PM
> To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
> Cc: hdegoede@redhat.com; linux-ide@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
> 
> On Wed, Sep 09, 2015 at 05:16:22PM +0800, Yuantian.Tang@freescale.com
> wrote:
> > From: Tang Yuantian <Yuantian.Tang@freescale.com>
> >
> > kbuild test robot reports the warnings:
> > drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> > >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> > >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> >
> > This patch fixed it by assigning 0 to px_is and px_cmd variables.
> > This patch also remove line 'struct ccsr_ahci *reg_base' which is not
> > referred by any other codes and thus a dead one.
> 
> Hmm... I think the problem here is that the complier can't know whether
> qoriq_priv->type would change across intervening function calls.  Maybe a
> better solution is caching the type in a local variable so that the compiler can
> tell that those two tests will always move together?  It generally isn't a good
> idea to clear variables unnecessarily as that can hide actual bugs that compiler
> can detect.
> 
> Thanks.
> 
> --
> tejun
