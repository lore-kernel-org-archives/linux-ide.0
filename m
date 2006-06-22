From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 0/6] AHCI suspend/resume support -- take 2
Date: Thu, 22 Jun 2006 09:10:56 +0800
Message-ID: <1150938656.7132.121.camel@forrest26.sh.intel.com>
References: <1149588926.29552.53.camel@forrest26.sh.intel.com>
	 <44996682.7060003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13654 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750775AbWFVCAP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 22:00:15 -0400
In-Reply-To: <44996682.7060003@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, lkml@rtr.ca, linux-ide@vger.kernel.org

On Wed, 2006-06-21 at 08:32 -0700, Jeremy Fitzhardinge wrote:
> zhao, forrest wrote:
> > This is the take 2 of AHCI suspend/resume patches.
> >   
> This no longer applies against 2.6.17-mm1.  Do you have an updated 
> version, or has the equivalent behaviour been merged into libata -> -mm 
> now?  Or should I just try and merge it?
> 

The patch was not for 2.6.17-mm1, it was against libata-#upstream.
Now I'm waiting for Tejun's PM patch being accepted into libata-
#upstream, after that I'll send out take 3 of AHCI suspend/resume patch.

Thanks,
Forrest
