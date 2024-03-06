Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69233CA4E
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758582; cv=none; b=FgTtMGQsRx9YtPdFHAQ2hHWqRKTOdZkQAwTbmb1xc10eJkA/c6+JuigxAjIEobRVu0+FG/NCH82jBkTSYWov39uWPTa8/dItSiKvlMVIqdWUV10d3h0jD2cNQerQN4KsaEyztNtdUSk2eMMxWPhvypqFiEBK6IDILbQosiASBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758582; c=relaxed/simple;
	bh=chMLxuuJhus8RSm2D1A6/5wioNv3E3Jgtwtcd+vx6Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7JqOqZFCJg5KIk6xA7IJqZfyFaENwe5eHrXptbSTeqQRNDnlkhtzis8jvJFvWyhXdR9cCC7ofFDEtWRHUdFtun5dtuz5MPR51dpU/FWGJJ5GYWK9RHWC9sgytaE5VL9L82QdbhC5JQNmTTLx1mnHncvQavlB/HS6UU7xbylkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIEgxQWG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIEgxQWG"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e64997a934so159130b3a.0
        for <linux-ide@vger.kernel.org>; Wed, 06 Mar 2024 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709758581; x=1710363381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24sGFAKUTMlFkQcWZBTL9mXGCoHWah/p2w8E9U7LrWw=;
        b=TIEgxQWGUdZcgyAEg02NRIfvaCCwulC7zCXCg1AHb+9YobU/p5rsm/rIo1tasgARhp
         X/TvboIjVw2DlRcyhTOmRgBNjc9OBvLjIY7Ut4LDiykEE8yoNWDWtQYKrifaADDsh4kz
         cU+h/mDqjUL5QC3pg30iyxu4dzx/E0WCKKCmMomydBC0jwPPKjqiTmujLTd6+6pgXJy7
         vPvTio0T4eapBN1yG8a5zV2jkP+ovmRmOYx6tqjmfSh4mSWmg+rIURyB4Ou2x8QGHl1S
         bG2b2MuR5r2c6/Yrm9nLU9c3xkQY4BcKPSUtljuPQkHiFJwAufLvABh1nyuLZZsf1uMR
         z5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709758581; x=1710363381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24sGFAKUTMlFkQcWZBTL9mXGCoHWah/p2w8E9U7LrWw=;
        b=VgtXzd9K2VhhAeAhGmrgAKvV8GFmUa9uyB65NJa8JkycrzYL6OjMS2PgAp2k9O6Dc4
         6SbjORm/c/pZ7Go/PdrQRhV8212SzOkRSnXIl63wlknaAQAZyf/+oQpBs/J7T50/jd9+
         +M6S1sxlSNXjqZ+knaZI4MXy0HojhF9spSzMc/ajUFWzDlIgryu0wHsD0YlElzWq6z3W
         N9xDengabj+f2s3sxVs9xSZ+5nkNXRuL2oz/3TVC+ULlLObvgEm+AxDxCuv6bvKf2vUO
         dltEgjHVR/+kYIqRWxeg5qOSKeYDkLa+xxpu8csaeZZrQxCtWnNFeBvNyLNVDxc2aBE3
         uHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJl4mKP6V5nwplIbZrgxo5m3TyUEfhj7RtLuypXr7k/pkkkGL1Jnblsx+ZGyp5baqpmcDyirwKGj5//bc+rkgw+70yXGYvUbp/
X-Gm-Message-State: AOJu0YwV73+U2pZAXIQollSai6vP6eq8z0pnRcAOPvgU4rOJIE2kZ/KE
	C/+OsXBzNV+bmRU6g4fyPpwQKVX0p9+9zSiTZrhSCt8rjhWhs3qP9pqewkSMsA==
X-Google-Smtp-Source: AGHT+IHGAd/L7VB6xNYd1gWzlLG1X1+due696CWjKmT3T0LUK5z6Uf8B1dNIBpiddnRm1LGtygv1Gg==
X-Received: by 2002:a05:6a00:1915:b0:6e5:584d:8d17 with SMTP id y21-20020a056a00191500b006e5584d8d17mr18776495pfi.15.1709758580424;
        Wed, 06 Mar 2024 12:56:20 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006e5a6e83f8esm10313892pfh.134.2024.03.06.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:56:20 -0800 (PST)
Date: Wed, 6 Mar 2024 12:56:15 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
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
Subject: Re: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZejYb4ykeF7Qx5a5@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com>
 <ZehLpV06mpHxjecc@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLpV06mpHxjecc@ryzen>

On Wed, Mar 06, 2024 at 11:55:33AM +0100, Niklas Cassel wrote:
> On Tue, Mar 05, 2024 at 05:22:24PM -0800, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
> >  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
> 
> Is there a reason why you didn't patch:
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c ?
> 

I originally patched hisi_sas_v1_hw.c as well. John Garry pointed out
that v1 HW doesn't support SATA so I dropped the change.

> 
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > index 73b378837da7..b5d379ebe05d 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> > @@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
> >  
> >  ATTRIBUTE_GROUPS(host_v2_hw);
> >  
> > +static const struct attribute_group *sdev_groups_v2_hw[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> > +
> >  static void map_queues_v2_hw(struct Scsi_Host *shost)
> >  {
> >  	struct hisi_hba *hisi_hba = shost_priv(shost);
> > @@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.shost_groups		= host_v2_hw_groups,
> > +	.sdev_groups		= sdev_groups_v2_hw,
> >  	.host_reset		= hisi_sas_host_reset,
> >  	.map_queues		= map_queues_v2_hw,
> >  	.host_tagset		= 1,
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > index b56fbc61a15a..9b69ea16a1e6 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > @@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
> >  
> >  ATTRIBUTE_GROUPS(host_v3_hw);
> >  
> > +static const struct attribute_group *sdev_groups_v3_hw[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> > +
> >  #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
> >  
> >  struct hisi_sas_debugfs_reg_lu {
> > @@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.shost_groups		= host_v3_hw_groups,
> > +	.sdev_groups		= sdev_groups_v3_hw,
> >  	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
> >  	.host_reset             = hisi_sas_host_reset,
> >  	.host_tagset		= 1,
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 
