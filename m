From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: end the r-word
Date: Fri, 7 Mar 2014 17:30:44 -0500
Message-ID: <20140307223044.GJ30778@htj.dyndns.org>
References: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
 <20140307130654.GC30778@htj.dyndns.org>
 <1394230968.4658.2.camel@dwillia2-mobl2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:48539 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaCGWar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2014 17:30:47 -0500
Received: by mail-qg0-f45.google.com with SMTP id j5so13317029qga.4
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2014 14:30:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1394230968.4658.2.camel@dwillia2-mobl2.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Mar 07, 2014 at 02:22:48PM -0800, Dan Williams wrote:
> From f1c564c4bcf1d636ff020faf4f3e644cf1c3d152 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Wed, 5 Mar 2014 19:25:02 -0800
> Subject: [PATCH] libata: end the r-word
> 
> Prompted by the social effort in the US to discourage usage of the
> adjective "retarded".
> 
> In this case we needlessly anthropomorphize hard drives.  The
> implication is that due to design deficiencies in the device reset
> recovery time is negatively impacted.  We can simply clearly state that
> fact.  "Exceptional devices cause outliers in reset recovery time." This
> steers clear of any unintended comparison of such devices to humans with
> cognitive disabilities.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
