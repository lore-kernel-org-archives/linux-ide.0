Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DEDF6B
	for <linux-ide@vger.kernel.org>; Tue,  5 Mar 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600106; cv=none; b=V4VUUZ+VP/AgjY8QTNjBEX/GKh53V92tAF+M4XgCcTzXHbxxtpiF3mJH8HTJ6ED9RwHIhHHFHSoQfYD2iSsUuec8i/F5AjZP+wPN91nngKFCXJuk71/eLG8+99XlNkHov32G3O3fs85xhEoNNbrULS1KMhA5+Lp3BxrTjfjhUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600106; c=relaxed/simple;
	bh=Lkfc/G8ms/B1ryJK1xsVEiMrQxCZ/WRnQdkAjTL0mho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJvBy3j9iC0TUCuxnOXFGK6LaBBYsVmKdiz6273BfXJr2QFQSJcDCIc8sseciXpO65JkKXinhBsCNjQDC1KTVDlJCbMbz63kvP0rualfaWbDpP+71H8u3ZLdwtzSEhjXYeh5Qw0YfKm4OpMcxSdljojTdcTnItdiq7w9swbhvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+XiTI+O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+XiTI+O"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5e4b1d1f1so1707377b3a.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 16:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709600104; x=1710204904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btVtPTsIaR+WT0iMCjgfqgg3/bD/6lXB1web0djMNd4=;
        b=J+XiTI+OiyFpIVuXLWnK2BFqQB7Q0dUqzPhr5TunkUOjyJm4rKDIvfwMRV83rBleFX
         0RF01R7SkXOtbs+frkf1W1kpRzU8R9MICGgldmkc1RcQMoQ1Yksy1h+PGhwFm+H+rqbp
         FJGIWLRBEdEL66u/Qu4LLWwAcG3yUmkTT5fv/ig6KF+LajkQ3sUjST4BZBGV4qDqaegU
         uqa93lJSTnw+Wpt3cfam1/kqiXv0yhELiyjRStXG3cSGJVxCvEPRQ3K75eOI5qEJQlk2
         L+bKvZqLLK77o4EZrHPXjJZu9l2ef5LJZOiAXDvLrmzIEAPt1SynPZd6Wu7gSXGMizaC
         5aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709600104; x=1710204904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btVtPTsIaR+WT0iMCjgfqgg3/bD/6lXB1web0djMNd4=;
        b=Abq2AhL/wzg7aisWNymzJz4++4X6qrwD23DR4yvsY+uV5gitwlPJrvAR9bYdPMVzQt
         77WdGJtwIjtT/cxt9C2mkC6vurMidjo84XjXfZq+c2PJxzw1yQWha4Qz9MAw3RCnYMF4
         4QR44MrqaPVslrsWKJZZqMisAP/bPX2uuU3tAAExxV7Nr1I/Yq46ITm/pTB+tLXCOHAu
         d8XRxC0kP9e8krxkWhfj1Cgkj4tD5y1jJEFEtbq10CLuJU93E0zy9I3v1+5ZKKBwQOU8
         BaYbdiLKHqZtHd1s/EYp5+RUqwW2UxcUfZoYWR938BtsXtZ2tdzuG1lYEJ/woH/w7LVU
         VrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4YoWyajw+lsULL/mMHPQ9poKjuMY8YrbZFo6K/fMW5zYGiGHghHVtCFmNI/lflf1ko2lmk2yjmLUSN7es0mXKcnnPrCcxtl6A
X-Gm-Message-State: AOJu0YxcHYYN9CRzJrkb+t0hpcUgyxmSfYbR+zIma3mnv1rM5Sn5nTDj
	wvvKXwdPkJ8bBX1yGq455I2Z4jL05SgAbwuD2KBv34H53w33qnEn8rKqeSjJ4A==
X-Google-Smtp-Source: AGHT+IFLGrgsbWFlFJR/Hz2/HI5I4sANrvV17uV2TvIZjM+n26W1s/MYVhCCdabv/P9oN0DoQYjq7g==
X-Received: by 2002:a05:6a20:43a0:b0:1a1:588f:5863 with SMTP id i32-20020a056a2043a000b001a1588f5863mr686353pzl.4.1709600103942;
        Mon, 04 Mar 2024 16:55:03 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006e4f644dafbsm7829664pfh.129.2024.03.04.16.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:55:03 -0800 (PST)
Date: Mon, 4 Mar 2024 16:54:58 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] scsi: libsas: Define NCQ Priority sysfs
 attributes for SATA devices
Message-ID: <ZeZtYjvMuSghJcMx@google.com>
References: <20240304220815.1766285-1-ipylypiv@google.com>
 <20240304220815.1766285-3-ipylypiv@google.com>
 <50427a28-1038-48ac-b3a3-6255267f9831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50427a28-1038-48ac-b3a3-6255267f9831@kernel.org>

On Tue, Mar 05, 2024 at 08:37:53AM +0900, Damien Le Moal wrote:
> On 3/5/24 07:08, Igor Pylypiv wrote:
> > Libata sysfs attributes cannot be used for libsas managed SATA devices
> > because the ata_port location is different for libsas.
> > 
> > Defined sysfs attributes (visible for SATA devices only):
> > - /sys/block/sda/device/ncq_prio_enable
> > - /sys/block/sda/device/ncq_prio_supported
> > 
> > The newly defined attributes will pass the correct ata_port to libata
> > helper functions.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
> >  include/scsi/sas_ata.h        |  6 +++
> >  2 files changed, 100 insertions(+)
> > 
> > diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> > index 12e2653846e3..4ecdfa2a12c3 100644
> > --- a/drivers/scsi/libsas/sas_ata.c
> > +++ b/drivers/scsi/libsas/sas_ata.c
> > @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
> >  			       force_phy_id, &tmf_task);
> >  }
> >  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> > +
> > +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct scsi_device *sdev = to_scsi_device(device);
> > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > +	bool supported;
> > +	int rc;
> > +
> > +	/* This attribute shall be visible for SATA devices only */
> > +	if (WARN_ON(!dev_is_sata(ddev)))
> 
> WARN_ON_ONCE() please. Same comment for all the occurences of this check.

Updated in v5. Thank you, Damien!

> 
> With that, looks good to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
