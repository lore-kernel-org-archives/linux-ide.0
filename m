From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA link power management issues
Date: Tue, 21 Apr 2015 11:31:21 -0400
Message-ID: <20150421153121.GD9455@htj.duckdns.org>
References: <3352987.ugV1Ipy7Z5@xps13>
 <2526428.uJaEqCTeIa@xps13>
 <9895435.0ZSsstcbFA@xps13>
 <2356903.cA2H5W8V2D@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36423 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbDUPb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2015 11:31:26 -0400
Content-Disposition: inline
In-Reply-To: <2356903.cA2H5W8V2D@xps13>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stripathi@apm.com

On Mon, Apr 20, 2015 at 10:02:12PM +0200, Gabriele Mazzotta wrote:
> On Sunday 22 February 2015 21:53:35 Gabriele Mazzotta wrote:
> > It seems that the following patch prevents errors when the policy is
> > changed. Could anybody explain why?

The device is generating a spurious PHY event after LPM state change
and the patch is ignoring the event once after state change.  It's a
bit too specific.  Maybe we should do this timeout-based - e.g. ignore
phy events for 1s after LPM state change.  Gabriele, would be
interested in making such changes?

Thanks.

-- 
tejun
