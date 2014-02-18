From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: ata-samsung_cf: Trivial cleanup in header file
Date: Tue, 18 Feb 2014 18:14:30 -0500
Message-ID: <20140218231430.GK31892@mtj.dyndns.org>
References: <1392608513-24294-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:51760 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbaBRXOe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 18:14:34 -0500
Received: by mail-qa0-f51.google.com with SMTP id f11so24096294qae.38
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 15:14:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392608513-24294-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-ide@vger.kernel.org, trivial@kernel.org, sergei.shtylyov@cogentembedded.com

On Mon, Feb 17, 2014 at 09:11:53AM +0530, Sachin Kamat wrote:
> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the files to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

FWIW,

 Reviewed-by: Tejun Heo <tj@kernel.org>

Jiri, can you please route this one?

Thanks!

-- 
tejun
