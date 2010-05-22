From: Tejun Heo <tj@kernel.org>
Subject: Re: A new drive with excessive number of load/unload
Date: Sat, 22 May 2010 17:12:43 +0200
Message-ID: <4BF7F46B.6070503@kernel.org>
References: <201005091819.48511.pierre.pallier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38953 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab0EVPMq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 May 2010 11:12:46 -0400
In-Reply-To: <201005091819.48511.pierre.pallier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Pallier <pierre.pallier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 05/09/2010 06:19 PM, Pierre Pallier wrote:
> My system : 
> EeePC 1005HA, 
> Hitachi HTS543216L9SA00,
> Mandriva 2010.0
> I counted exactly 117 load/unload cycles in one hour.
> 
> Setting APM Level to 254 solved the problem.

When I first started storage-fixup.  I thought it would be a temporary
thing and vendors would pretty soon stop shipping broken devices.
Well, that doesn't seem to be the case and storage-fixup is really not
the solution.  It will always cover only small fraction of actual
problem cases while unnecessarily increasing power consumption on many
configurations.  It's too small and too big a solution at the same
time.  More succintly, it sucks.  :-)

I've been trying to contact vendors and am talking with at least one
of them but if vendors are okay with the current situation I don't
think there is much we can do.  It's a problem between hardware
vendors and their customers and I don't think it's wise to continue
providing this half solution which is doing more harm by masking the
real problem.

Thanks for reporting and I'll add your entry to storage-fixup and also
update ATA wikipage in several weeks.

-- 
tejun
