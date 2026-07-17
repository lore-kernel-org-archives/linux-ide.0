Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0B37CD50
	for <linux-ide@vger.kernel.org>; Fri, 17 Jul 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309556; cv=none; b=Maep2Plx31R9HJD2t/ku60UPZAahotnqVKZ0svA7Z8waPrVeSPtvFXQWGk8lNZlOHsKzRdJsenIbcIqVEfObqSvgoYIdPYmELdGWq0hqjfgH/fHE0J1orCG2WEEXpMdnvrd5wZs3/ggAwJh0hv+jo+gXzgyAuf/sCcg2sTHuHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309556; c=relaxed/simple;
	bh=l/iqzVV9ZiDNg6fsxIgZRa3JR8gePCpl0o8ow2O/eiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAYHg6EjTqpg18lhVU4R685/e8A3actPDlOw4ZOZWI/OBDvKe/+i7zDisRUCVyhdITkzPV5PSSFtc+3IE+lcd8EiizcqviLsNMR5Go1ZVz6U12V/kAD5zVcPZ6LgQIghU0P+4h+Qbq7ogHg5YtNDJ1QlCF6/X+dXLAJUyerI63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNVv2bYk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNVv2bYk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso201615ad.1
        for <linux-ide@vger.kernel.org>; Fri, 17 Jul 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784309554; x=1784914354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bBva/snWMY/9I+o/+Fcl/WbhxHZizWnbFHjWgXP46+c=;
        b=MNVv2bYkE3NSxuL+omZKJp2L0xYroqRoggzbJpGXFrZYeMMCRWSXtU1T+KR78ZKQCk
         ApXMJt/rJUOoVI1AJtRmxJHwDN1ihcG6VFCYDl/6Mh50zf54B8AitcE+xfgBy6MeUeg5
         o+37goCAIIZe3SqbU4sIQl+QoAoThmaYT1ghBs/15lNHUW3zwegrc6nl5LA6r9nCsBGr
         LuVikSJAVGX4iS9KVDSPLdxV3vTIHCsEs3GvlQtVBXoNTJGUuYJLj91FX/KJktBUAFSz
         DMcKzbTZt65+pbc97SurEUGZwk+F2qaD6/5wID5laEZ6NEbPSjbSclq25NgprrGMobIg
         oi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309554; x=1784914354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBva/snWMY/9I+o/+Fcl/WbhxHZizWnbFHjWgXP46+c=;
        b=SRYGVHFXxVbzEbl0PWzIAtmqvPU+T1yiZ5rFTvSEvVbVupvkFevGqhuLDF1OsdOTh/
         Zy389gdAcSo+B2pvuoz3Dy7SLGOhcPq8bTNC7+0AZ101Qt5CjU2d63klnyjbKeb2IB9r
         vnCZp3M9rbB0l+dKrDmQvIqeRd3RGz0CMwKLA1A7gdJPvlckwtNBtwiycuE6jwGBfUKW
         W906QIez+EuZf6uy9sT10jo+fm+R2m8GxHN4QtVLobafiUUlRWY0TE0YqeoWhIivjUx2
         witOUHB1+MhJYitkOe6Nbnnopl63GiCPPD71r55ayYwGVedZrs8/gwnh1uLfbMOlYcrJ
         xjSQ==
X-Gm-Message-State: AOJu0YzWWr6I3L3f/b40UDXHQnAmmsfaxAPsQIyf5GUZhDfs8O+pJ4JT
	2zAThZZ05Rh27HdE8Uxm75LMvw26nHb8DKtdC4HSBfn/jU8qxVTzaYlF7QsgwLRHJg==
X-Gm-Gg: AfdE7cnqTAd4wF/RX32f58Ynw/FS+wg6WZX1DDGDVZtAivCRNMFGRCdmE/M6Lgzj9ud
	jbVFFWj6vz7f9eIGZ/srP9ukFqpn/bqExT8BXjqJBdPg1ZgTkuLLlslZReoEnAo0qUSiok9EyMs
	sEjOngfd+ljFii2id7e0hn0maHDEw2LZ4/dWUu18vN2XHwtwqzHeq8KLdAFXJ6XCj4oMBPaSeIo
	yohIAjxmLI+hVjeVKWPF1RjICJ8OQzF+aNDuLPrbh83NpsMr9VZiyuHSmfDmKpIgh2TzHrjhNWT
	iJIcgB8nMcg9t+5eVAMsO3RYloAZr+ircy7sG/lhht8CVJnrmiKuXZPSEQRmmbdJrCifGwhD0E8
	ln9Sn2LF5A3Rt96zHMDnLWL4MDRwWsJy15CwykaUZP6WySv17GLRcsuPb1lVm9EB6jS3LJOATwy
	V07OqGlXd7GuiGL7riSH3iYOqubQV91jwx6fvs2g==
X-Received: by 2002:a17:903:240d:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2cf44f77f0cmr298235ad.0.1784309554077;
        Fri, 17 Jul 2026 10:32:34 -0700 (PDT)
Received: from google.com (249.65.83.34.bc.googleusercontent.com. [34.83.65.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9ef6dsm1508824b3a.57.2026.07.17.10.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:32:33 -0700 (PDT)
Date: Fri, 17 Jul 2026 10:32:30 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/2] fixup handling of timeouts with deferred QCs
Message-ID: <alpnLgBhz0pb9wDv@google.com>
References: <20260716083847.926102-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716083847.926102-1-dlemoal@kernel.org>

On Thu, Jul 16, 2026 at 05:38:45PM +0900, Damien Le Moal wrote:
> This patch series fixes libata and libsas to correctly handles deferred
> queued commands in case of a timeout error, to avoid excessive delays in
> waking up the scsi EH task.
> 
> Igor,
> 
> My apologies for the churn, but please retest !
> Also, I added your Signed-off-by on patch 2 since half of it is yours.

Thank you, Damien! Test resuls look good.

I saw you are planning to send v6, I'll wait for it and will retest again.

Tested-by: Igor Pylypiv <ipylypiv@google.com>

> 
> Martin,
> 
> Once reviewed, I or you can take both patches ?
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
>  drivers/ata/libata-eh.c             | 38 ++++++++++++++++----
>  drivers/ata/libata-scsi.c           | 56 +++++++++++++++++------------
>  drivers/ata/libata.h                |  2 +-
>  drivers/scsi/libsas/sas_scsi_host.c | 15 ++++++++
>  include/linux/libata.h              |  3 ++
>  include/scsi/libsas.h               |  2 ++
>  6 files changed, 86 insertions(+), 30 deletions(-)
> 
> -- 
> 2.55.0
> 
