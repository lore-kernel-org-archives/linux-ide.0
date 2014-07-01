From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] libata: implement dump_id force param
Date: Tue, 1 Jul 2014 16:51:06 -0400
Message-ID: <20140701205106.GD12459@htj.dyndns.org>
References: <4BF90A7F.80309@kernel.org>
 <4BFC6059.3080505@garzik.org>
 <C734FD3F-7CAB-40C4-A3AB-916A30E173DE@usgs.gov>
 <56B984A8-0CA0-4FED-A3D2-6CDE82AA5FE4@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:36283 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaGAUvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jul 2014 16:51:09 -0400
Received: by mail-qa0-f47.google.com with SMTP id hw13so8064928qab.20
        for <linux-ide@vger.kernel.org>; Tue, 01 Jul 2014 13:51:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56B984A8-0CA0-4FED-A3D2-6CDE82AA5FE4@usgs.gov>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Larry.

On Tue, Jul 01, 2014 at 11:51:54AM -0700, Larry Baker wrote:
> I see what happened.  Tejun sent me two sets of patches: one to
> implement the driver dump_id kernel parameter and the other to fix
> the problem with the buggy CF card.  (It lies that it supports ATA
> MULTI -- which is actually required by the standard!)  Jeff only saw
> the first set, which is what he applied.  They are in the current
> Linux source tree.  What are missing are the patches to recover from
> multi-block transfer failures by falling back to use single-block
> transfers.  Here's Tejun's e-mail to me with those patches (ready to
> go?).

I dug out the original patch.  It looks like I was waiting for
Tested-by.  Has anyone tested the patch at the time?

Thanks.

-- 
tejun
