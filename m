From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] Power off empty ports
Date: Fri, 4 Mar 2011 10:06:44 +0100
Message-ID: <20110304090644.GC20499@htj.dyndns.org>
References: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33507 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759286Ab1CDJGt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 04:06:49 -0500
Received: by bwz15 with SMTP id 15so1890181bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 01:06:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Thu, Mar 03, 2011 at 10:21:16AM -0800, Kristen Carlson Accardi wrote:
> Give users the option of completely powering off unoccupied
> SATA ports by introducing a new link_power_mananagement policy
> option "power_off".  When the user selects this option on an
> empty port, we will power off the port by setting DET to off.

Why introduce another LPM state?  Just do power off if min_power &&
port empty.

Thanks.

-- 
tejun
