From: Tejun Heo <tj@kernel.org>
Subject: Re: SuperMicro X8DTL-6F motherboard, Intel ICH10 SATA, SiI3726 SATA
 port multiplier
Date: Tue, 09 Mar 2010 17:14:22 +0900
Message-ID: <4B96035E.80503@kernel.org>
References: <alpine.LMD.2.00.1002201350570.16281@rhpcserv> <alpine.LMD.2.00.1002221542010.28521@rhpcserv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49414 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab0CIIO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 03:14:26 -0500
In-Reply-To: <alpine.LMD.2.00.1002221542010.28521@rhpcserv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd Pfaff <pfaff@rhpcs.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

On 02/23/2010 06:02 AM, Todd Pfaff wrote:
> Despite the appearance of partial success in my syslog messages below (ie.
> PMP appeared to sorta kinda be trying to work, almost), I've since read
> some more that leads me to believe that Intel ICH10 does not support PMP.
> And Intel authoritatively says so here:
> 
>   http://www.intel.com/Assets/PDF/datasheet/319973.pdf
> 
>     page 538, section 14.4.1.1, Bit 17
> 
>     Supports Port Multiplier (PMS) - R/WO.  ICH10 does not support port
>     multiplier.
>     NOTE: This bit must be set to 0.  Port multiplier is not supported by
>     ICH10.
> 
> So, I give up.  I edited the wiki page here accordingly since it was
> wrong:
> 
>   http://ata.wiki.kernel.org/index.php/SATA_hardware_features

Eh... some variants of ich8/9/10's definitely support PMP as indicated
by the PMS bit.  Reverting the edit.

Thanks.

-- 
tejun
