From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: Merge pata_samsung_cf.h into
 pata_samsung_cf.c
Date: Thu, 2 Jan 2014 07:45:47 -0500
Message-ID: <20140102124547.GD11501@htj.dyndns.org>
References: <1388632171-17732-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:44560 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaABMpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jan 2014 07:45:51 -0500
Received: by mail-qc0-f179.google.com with SMTP id i8so13421292qcq.24
        for <linux-ide@vger.kernel.org>; Thu, 02 Jan 2014 04:45:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388632171-17732-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-ide@vger.kernel.org, patches@linaro.org

On Thu, Jan 02, 2014 at 08:39:31AM +0530, Sachin Kamat wrote:
> Since pata_samsung_cf.h is referenced only by pata_samsung_cf.c, merge
> it into the .c file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to libata/for-3.14.

Thanks.

-- 
tejun
