Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9849376A0A
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780485; cv=none; b=fwqLhMsxqrhL5t4ehYBBChayWymLN6qqEtW14aEaIsALi9x+MCaHy68czkaLlk9KFhCV4U6Mmib+yM6q/FGTj86elTRGZvxweMF+lGh9SjK+sNCnWbNbZ17aueUV1jbDOtghgrieBAAyzCCdTxuA/xgKYI21oZ7oegX576v5NbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780485; c=relaxed/simple;
	bh=35mNg/AyD4v2flAtAyN0ZZj4wEBfAt3e83VUm//qg5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+RDHxSDIpYDMu59LEGeyeul/+TsHms+MZKoivuS66CREAsCR6z/DUWrFfSmu9demkA6p+tuUFTmSbQmvFWkQ/nX7Q5a3b9gREpse0cvCCS7fyLH28yHX8imrBUR2Sn6yurtGvQRvptMZwoO3XLll7q9f3YzkKYgBLa8kgOPdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvi4/RvY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvi4/RvY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso31125ad.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2026 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784780447; x=1785385247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h0IhZi1OKFPkcst+4yI24dUPIzJuM4pvOmvOBFDuDOw=;
        b=fvi4/RvY3nNf8YGlD5NB3gdpoVgFY86KSbODehp++sw7kiI3ZkOGiIqcSFPt9n+2HW
         bzKrJX+g4+FLeq4uSTieVVvcKDYRJFfxSFr+ZXzlEIUTnY/q6W5FrbQYU3QWMaYzGRLj
         mkawGYSNxtSjH2eUXVdR8JDhedIBXBOkEtjk4a1ixk5AyW26WGneKTsIJ/HbqIo8lQz8
         XqJGgSNJ+kAwt4S9SENIvocmERezD7pnne3+5TZSySpFSeuZZF6Sqx2UHBI6USqNkqCw
         IEMDJSgGEw8u926ODqdvzJqdkcqbHIj42hg6SfjSnmueBwHbtk31AaA4zowsOLrQB1m1
         Q55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784780447; x=1785385247;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0IhZi1OKFPkcst+4yI24dUPIzJuM4pvOmvOBFDuDOw=;
        b=gqSd+ACRv3ihx20xllBZK6lc5t7AhiTJyjW5vXWjwFU6q5XnZkDfBVEa+/7bnyXYbt
         3jYgJ5t2x7sbbFid756zasO4EFHCO10Hbl/shsysYilK87bRAdrmGpndQZGufQ68mT5z
         GkRHAXigXQLi0aZxQjz9DPCwuaQc0BVt0gPLv8IQHelAPOtSQvR4KnEbSamQnhEV3mY/
         2Ligg1yIRhT53wESLaPEoiMmDXzlWnHHXDxspoE0ErAMFWRK36laujAsHMkCKIebeknA
         IwsPxsnnFAvawFD3mkQ33CjWXyx9m0nXwlmGgiyAffMfLGKlx4+S9V/wMe/Sj3EqCj08
         b9fQ==
X-Gm-Message-State: AOJu0YwRNcz+cgdpPR92Eps8S5o7NYKTZxMa74zFlyYPnJI/7hq382JU
	HBXT2YHmWyJx+6zGJlYEiqWjTtFHmetClqIwl5BAJjDoNdDdA3E78BR95QMFUP5NbA==
X-Gm-Gg: AR+sD13IKgEDRP3bqAFAvry65PdOhxbijG5EXs1dcPpvWkAtyN9F++3o0GqBEQG3nOu
	4TcSRtR85NGbL7uwcgWKo9PvXPWejVzQMRczxZ+jAW268paIIGU+RVJ8D47O/UUc++/UeetWVRW
	KaW1Nl72FY89eq5C8b+wP0NmN9OTaav4xZ8IdgApIMtCpcZPH4yRZb+0bFlD8GeInbx8bIJo4bn
	ZDO14fTL36yU5498QAI3555staH1Lf+addNKoLxXPe1COB1qsyM3O1NWA5rwbE+9e52M9lyfjCN
	cHDCuFSG0UJCwF2O+sXzENMDUS/n3TfktbpfRS5ubDIXg7RVGoB92AnrjPLpiOPiFmJ+x/lXBXU
	Nkcb9nXohtg2yb7p9DXoNYis8cYhptgJMhwN1gTCFMMl938SKZqhMQrNoVGcU+ElM+pLnW4WjvK
	hRLfu3ncOXblc/ZbIAA85C95ql120JN7RvVOCl5g==
X-Received: by 2002:a17:902:f60e:b0:2c1:ee6e:4e49 with SMTP id d9443c01a7336-2cfa53828bdmr1036105ad.26.1784780446559;
        Wed, 22 Jul 2026 21:20:46 -0700 (PDT)
Received: from google.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17576a80sm2309404b3a.36.2026.07.22.21.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:20:45 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:20:41 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v7 0/2] fixup handling of timeouts with deferred QCs
Message-ID: <amGWmbJXLXGxrFso@google.com>
References: <20260721064027.2081195-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721064027.2081195-1-dlemoal@kernel.org>

On Tue, Jul 21, 2026 at 03:40:25PM +0900, Damien Le Moal wrote:
> This patch series fixes libata and libsas to correctly handles deferred
> queued commands in case of a timeout error, to avoid excessive delays in
> waking up the scsi EH task.
> 
> Igor,
> 
> My apologies for the churn, but please retest!

Test results look good! Thank you for all the time and effort that you
spent on this issue. I learned a lot!

Tested-by: Igor Pylypiv <ipylypiv@google.com>

Best,
Igor

> Also, I added your Signed-off-by on patch 2 since half of it is yours.
> 
> Martin,
> 
> Once reviewed, I or you can take both patches ?
> 
> Changes from v6:
>  - In patch 1, go back to using direct command completion for retrying
>    deferred QCs, but adds libata EH trigger to avoid problems with the
>    block layer immediately re-issuing the retried commands. This same
>    method also allows directly handling timed out deferred QCs, which
>    simplifies libata EH.
> 
> Changes from v5:
>  - Reworked patch 1 to have deferred command retries all go through libata
>    EH to ensure that we do not run into issues with the block layer
>    immediately re-issuing retried deffered commands (which would create
>    again the problem we are trying to solve). This change necessitate the
>    introduction of a new QC flag and changes to the completion path for
>    commands to ATAPI devices.
> 
> Changes from v4:
>  - Simplified sas_eh_timed_out() code in patch 2
> 
> Changes from v3:
>  - Reimplement ata_scsi_requeue_deferred_qc() in patch 1 as
>    ata_eh_retry_deferred_qc() so that all requeue pathes use the same
>    function.
> 
> Changes from v2:
>  - Modified patch 1 to avoid the problem reported by Sashiko that requeued
>    deferred QCs may be re-ssued immediately by the block layer, thus
>    potentially keeping the device busy. The modification now relies on
>    libata-EH to perform the requeue instead of immediately doing it from
>    the eh_timed_out operation.
>  - Modified patch 2 to use the new helper function defined in patch 1.
> 
> Changes from v1:
>  - Modified patch 1 to ignore timed out deferred QCs in
>    ata_scsi_requeue_deferred_qc() to let ata_scsi_cmd_error_handler()
>    correctly handle this case.
> 
> Damien Le Moal (2):
>   ata: libata-scsi: terminate deferred commands on time out
>   scsi: libsas: terminate deferred commands on time out
> 
>  drivers/ata/libata-eh.c             |  29 ++------
>  drivers/ata/libata-scsi.c           | 109 +++++++++++++++++++++++++---
>  drivers/ata/libata.h                |   3 +-
>  drivers/scsi/libsas/sas_scsi_host.c |  15 ++++
>  include/linux/libata.h              |   4 +
>  include/scsi/libsas.h               |   2 +
>  6 files changed, 127 insertions(+), 35 deletions(-)
> 
> -- 
> 2.55.0
> 
