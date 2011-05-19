From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA PMP support
Date: Thu, 19 May 2011 17:38:26 +0200
Message-ID: <20110519153826.GM627@htj.dyndns.org>
References: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44300 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab1ESPkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2011 11:40:16 -0400
Received: by fxm17 with SMTP id 17so2039737fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2011 08:40:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, May 19, 2011 at 05:12:02PM +0200, Michal Suchanek wrote:
> I bought an eSATA enclosure (evolve doubledock) and I wonder if it can
> be used as a PMP.
> 
> My eSATA port is connected to ICH10 AHCI controller which reportedly
> supports CBS  PMP.
> 
> When I connect the dock kernel sees the port going up and I get access
> to one of the drives.
> 
> I can access a drive in either slot but if both are populated only the
> primary slot (marked source) is visible.

Can you please post full dmesg output?

-- 
tejun
