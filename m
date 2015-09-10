From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Thu, 10 Sep 2015 06:17:08 +0000
Message-ID: <DM2PR03MB574733935AECD0167EEF580FA510@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
 <20150909140130.GB22909@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0119.outbound.protection.outlook.com ([157.56.110.119]:62023
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751594AbbIJGRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2015 02:17:12 -0400
In-Reply-To: <20150909140130.GB22909@mtj.duckdns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



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
I am not sure if the warning can be removed this way.
But I will send the patch as your suggestion. 
Unfortunately, I can't produce this warning no matter if I add -Wuninitialized.
So please let me know if the new patch is working.

Regards,
Yuantian

> Thanks.
> 
> --
> tejun
