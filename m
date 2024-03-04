Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9D18057
	for <linux-ide@vger.kernel.org>; Mon,  4 Mar 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541801; cv=none; b=PiGKZHZI893vBZKLigRF3U5x96BYP4eXbN0rkT8fnx5fiaXCDSWw2EqsZu2i4wQMmtjdbuPS0kfaDvVZ8ESUMZa26iWE3eE+Jj3/OEM3HAcBdpIXd9JAojlZPzq6yZYRC/nnkGnC/wGbXNlQgyhBrKMJt81BlIRbI+s6eRB9v1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541801; c=relaxed/simple;
	bh=pCnufLy/HtQxFmJvCJIBchOyotPLyFf9InIAEZFtzyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljcMZ4SQ+LTgTUph6z1dH3DqncW7MuMpABBU3liQ00y/KG1/wSROnb58rMCjILkCxu6ZWt8ONqOCcyzUi50ivrlLmm4uwOf6zsod5conv82xJP4gIAKiLSDLtfTEsQHUhhUvdo0MG+H+BbhifWS1C7/COGbaQU/Qdg87070u7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Kwl55zxb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Kwl55zxb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so5706992a12.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Mar 2024 00:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709541796; x=1710146596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5Tdy8e2M2LwA/AfaCGwdWZIPI/u425rq1VFhpOUNQA=;
        b=Kwl55zxbriz3widw4ypAfXgsfjohHhIcVTW9s8csoN6s68Tf+plwyiKeHzpxnEa7jb
         LCSGRAiiEWRj0O2lxFE9YQjKtO+zo8gOQsvqFEEw2AuBYMMQbnuk+mJ9xlYoJgqL6nCX
         RkzVhvILqUZJyynV9XoSbRLF/+wo8ho1AruF+ODajQCxvcflz3nNzILZhjBdmnhKvbVa
         JyJpYHhmIt7AsybYrt81ACoDUftq4/cTxAHwwF4qEc9kvm/b+eMHl+ZsE6EgWk5vZu8a
         z1JJpjrR0tCKAy/komjO4jAY4vk4jB2oYcu5CWmd1iT/XRtXMdbKEPGh8SAyYcjxxM6L
         RNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709541796; x=1710146596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5Tdy8e2M2LwA/AfaCGwdWZIPI/u425rq1VFhpOUNQA=;
        b=WF8BPyak3CH/ymUMlwmFqkqdHYLOPTx52bkkD74SX6VhBIoSk2cWpjD+sTVA4cXXwJ
         CDAUPO68zPiDmW5vC8z3fFV0gyCmle0GXBVvYOS3Yysx//QS8zq3VSrhZnEMqs83lyLX
         HR1bwlc66tPu5/z6klH2DVyrbiLXl33oD97cRt7pvbq2cHjHSQ3ToK63BmRGUV9Gpqkj
         0gWEofl7IiNwVhNJjPCVo+LsoOs9/8/VwRubQeTabR6YzdI17+9h5RgmKjYHHFreBjM5
         7mxyoAuqqATmqi6OecH3AWroGY7VSGcpvTnznYUEhpYQS2tNSlOXkIVxFnT5cJf1ynkX
         eVbg==
X-Forwarded-Encrypted: i=1; AJvYcCUUIXxrqy+iGzIrMzn6qo17dhq99+VLOfPXknvJsgiaGLj49YvTxmu7Cvbs+hPa3plbUYQNipOUjKa+LCQvWjiqAb415TetPGaR
X-Gm-Message-State: AOJu0Yz33fd43r6ULm7yV5xX0ZFmZaHnyhkbmAZEr96o5tMho9SEHCBI
	DAGZc1mQmCVnh6VfjquSRcHVSbHIa7qixG2dD9n+xHDacqQtwv84NXRb2CLCLHgNxnIP9oyqrqZ
	fdOX7lLT28/9aLvC6P1MvrFTXxX5RKRmOL2ff2w==
X-Google-Smtp-Source: AGHT+IFh3iQrNw66aCjZWvQhrTZ7/Vd8fhUefXxPExNqJlkSHixSsXeU4cwRVs5xuqmPK6lnUcEq9LU+l+TqakQxmJs=
X-Received: by 2002:aa7:d04c:0:b0:567:2870:1f1c with SMTP id
 n12-20020aa7d04c000000b0056728701f1cmr2747833edo.19.1709541796556; Mon, 04
 Mar 2024 00:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com> <20240302201636.1228331-4-ipylypiv@google.com>
In-Reply-To: <20240302201636.1228331-4-ipylypiv@google.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 4 Mar 2024 09:43:05 +0100
Message-ID: <CAMGffEkP4yCX8ngoApbStNdeBL6DbAcwa+U9O8q5gF8+WyCEPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes group
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 9:16=E2=80=AFPM Igor Pylypiv <ipylypiv@google.com> w=
rote:
>
> The added sysfs attributes group enables the configuration of NCQ Priorit=
y
> feature for HBAs that rely on libsas to manage SATA devices.
>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>  drivers/scsi/pm8001/pm8001_init.c | 1 +
>  drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm800=
1_ctl.c
> index 5c26a13ffbd2..9ffe1a868d0f 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] =
=3D {
>         &pm8001_host_attr_group,
>         NULL
>  };
> +
> +const struct attribute_group *pm8001_sdev_groups[] =3D {
> +       &sas_ata_sdev_attr_group,
> +       NULL
> +};
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index ed6b7d954dda..e6b1108f6117 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht =3D=
 {
>         .compat_ioctl           =3D sas_ioctl,
>  #endif
>         .shost_groups           =3D pm8001_host_groups,
> +       .sdev_groups            =3D pm8001_sdev_groups,
>         .track_queue_depth      =3D 1,
>         .cmd_per_lun            =3D 32,
>         .map_queues             =3D pm8001_map_queues,
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm800=
1_sas.h
> index 3ccb7371902f..ced6721380a8 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm800=
1_ha);
>  void pm8001_free_dev(struct pm8001_device *pm8001_dev);
>  /* ctl shared API */
>  extern const struct attribute_group *pm8001_host_groups[];
> +extern const struct attribute_group *pm8001_sdev_groups[];
>
>  #define PM8001_INVALID_TAG     ((u32)-1)
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>
