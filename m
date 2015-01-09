From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA link power management issues
Date: Fri, 9 Jan 2015 17:02:53 -0500
Message-ID: <20150109220253.GI2785@htj.dyndns.org>
References: <3352987.ugV1Ipy7Z5@xps13>
 <20150109220018.GH2785@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:54656 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbAIWC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2015 17:02:57 -0500
Content-Disposition: inline
In-Reply-To: <20150109220018.GH2785@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Jan 09, 2015 at 05:00:18PM -0500, Tejun Heo wrote:
> It's not normal.  It definitely doesn't happen with all devices.  I
> guess it could be a quirk from the device side.  What's on the other
> side of the connector?  Can you post the full kernel log after such
> incidence?

What happens if you comment out the DIPM part of ata_eh_set_lpm() -
the first ata_for_each_dev() loop in the function?

Thanks.

-- 
tejun
