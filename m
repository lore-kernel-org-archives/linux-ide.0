From: Tejun Heo <tj@kernel.org>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Wed, 13 Jul 2011 09:34:14 +0200
Message-ID: <20110713073414.GC2872@htj.dyndns.org>
References: <20110609143755.GA2615@htj.dyndns.org>
 <4DF136FF.2010404@seoss.co.uk>
 <20110610102403.GE15235@htj.dyndns.org>
 <4DF249BB.3040808@seoss.co.uk>
 <4E14C6ED.5040208@buttersideup.com>
 <4E15A2F1.7080106@seoss.co.uk>
 <4E15FB4A.809@buttersideup.com>
 <4E15FD43.6030701@seoss.co.uk>
 <B9B10C29375C5B40A2D240808654F60E5EE470A72D@SC-VEXCH2.marvell.com>
 <4E16D37D.1030701@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42256 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1GMHeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2011 03:34:19 -0400
Received: by bwd5 with SMTP id 5so4621721bwd.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Jul 2011 00:34:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E16D37D.1030701@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: Hubert Bailey <hbailey@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Larry Li <lil@marvell.com>

Hello,

On Fri, Jul 08, 2011 at 10:53:01AM +0100, Tim Small wrote:
> On 08/07/11 05:42, Hubert Bailey wrote:
>> The 9125 is a simple controller without a internal processor.  The
>> 9123 contains an internal processor to enhance RAID 0/1 operations.
>> If you are testing in a JBOD configuration you will not take
>> advantage of the 9123 internal proces sor.
> 
> OK, that's fine.  I have a nice fast CPU in the system which runs the
> Linux md code (which I can debug if necessary) with very high
> throughput, and it even works across controller cards.  A JBOD is what I
> want.

Yeah, especially for RAID 0/1, there isn't much 'acceleration' to do
and with the abundant extra cores and vast amount of main memory these
days hardware support for even R5/6 doesn't seem too useful.

> Please could you acknowledge that there is actually a problem here?  I
> don't know whether it's with the 88SE91xx controllers, or with the Linux
> AHCI driver (or Linux PMP support), but this is clearly not correct
> behaviour.  This fault doesn't appear when using a SiI3132, or an
> 88SX7042.  I don't currently have a different AHCI+FBS capable
> controller to double-check against, but may be able to check against an
> Intel one in a couple of weeks time.

Oh sure, it's not working properly.  Looking at the performance
numbers you posted for Windows, it seems the Windows driver isn't
using FBS either.  Larry, Hubert, can you guys please confirm this?
Should we blacklist FBS support for some of marvell ahci's?

Thanks.

-- 
tejun
