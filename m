Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58143FE2E
	for <linux-ide@vger.kernel.org>; Sat,  2 Mar 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410841; cv=none; b=M2zsQ5YaEyXZrc7jBhW4mLNy/xXejx+grkgDVv5Ds1fczHGaGpl68PxBS4xDJF6a/EXF2/nHDSa0hjkREo0v3Jxv2aWkXI++ySiWz7xYPiWbS5iBYeAylOWeGmobKj/75rRd586+/toaMj6I0VvRQQkXG3Z/tWKowtahn0e21nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410841; c=relaxed/simple;
	bh=Il4TNeGZ87lBBA6QRmI8wfKgBRijwa3cS1rM+/WJJ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2urpckvbK24y6Ilro3oKB5DKff6Pu0ct0/7/bCvgOR+sr1vrQzcjNQgxKAgTZP9CAh4lcXS2OJWs0X29eywVFJU75hZwR1jAdeZNFLQ3Gy98X37CgzU3TNWj6BDsuumWLCtmRcIr6+Jf+kiTkI/ayOcFKcquK4oy9iWX34Gv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEQnPFPG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEQnPFPG"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-365bd66bea9so12178825ab.3
        for <linux-ide@vger.kernel.org>; Sat, 02 Mar 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410838; x=1710015638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLDiv6aj5j9bGmsHcUHk2rwN974mAAiIOmfVyl85S3Y=;
        b=pEQnPFPGSYYQzvR7/P6Eq2tmOmpgqbZU/P5R+dtiz5jDj6CfCcNUlybIW0oeF3Mt6Z
         hM39jFXTtG0Tp9XnFgPlYxRS4KtYf8iW3JvNI/K4roBWfQ+j85IzCz1RkHgH0rvRnT9s
         LdN9PuKPPUcj6IFL5SnZh6AoQYPLHYXAuGz+cAnaYi99H7Cg/pYHqi2e8AGItdhk76L2
         Z9rbMFDfN7ZrkbJnrLNfiuxbYB3tFYDjFR3EbRxFZmLAe8J5BIjBAAmx3Fq3cePFzCNg
         EdFFZGFbVz7VFecH5ACQnaeQKFjnumYCMQ17cJB5hJ0OWIEbSrYQTt1eRoyE7RHG9QuW
         i4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410838; x=1710015638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLDiv6aj5j9bGmsHcUHk2rwN974mAAiIOmfVyl85S3Y=;
        b=pgkpcrCqAXVKz4CeDc7HV8+k5uSEA/bbkqfHDoN+lpmwgeiubNvpClT62EgaSkd3LW
         BMM6j0W9gByji78Q2g4qC6+9lu9FbjhSG0re1dYIZTe7sF+nWV5hHmWuQ9yliJV1msj6
         +6+j7bx2QLXWLXQserkCJGFlMEMmtlNqGb22SwwccbyCOTOJs/5vTwpGtcGTMNhIyVfJ
         B68KPWdcREajjvxI3X3c82o7T9YL5UHkku927dMQqtLx6bTxU24F4qlXy6ePCvSJqnIN
         F0lKUn4ZyukIsGpT3y7CGTmco1FCxx9+ujGx17u7XAEyLTzmiyBlLu1iayb7wDjtQQO2
         +0tg==
X-Forwarded-Encrypted: i=1; AJvYcCWGOCOlGiYwZ+t7XjZpbySKqEMC7pP0BjFrMGUySViM0SY7uhSKJvzhd0cp6Omb4MFNB1DDdYgmd2ZmSzLDaFvsRv7TPiQu9R41
X-Gm-Message-State: AOJu0YzKFeuZeMTOZLykVQB3/MiTs4GA4ITt3O/0BR3QkJrdGNgZx2p/
	Y5L/UT3TIaijTqbOwlswZ24zPhwjvIjek3DE/npnFtRNmPEHxzD7S9dAHv+1xw==
X-Google-Smtp-Source: AGHT+IGWHtZpooNRhjtLGiXDKWHHb3lExF13M/bZvYdKWRjeMnuIBH8ANCqhWwP12f0YF8dMR1h+PA==
X-Received: by 2002:a05:6e02:1564:b0:364:2239:a89b with SMTP id k4-20020a056e02156400b003642239a89bmr7054185ilu.11.1709410837857;
        Sat, 02 Mar 2024 12:20:37 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
        by smtp.gmail.com with ESMTPSA id 7-20020a630107000000b005cf450e91d2sm4984639pgb.52.2024.03.02.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:20:37 -0800 (PST)
Date: Sat, 2 Mar 2024 12:20:32 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>, TJ Adams <tadamsjr@google.com>,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZeOKEFC10lD-9Kle@google.com>
References: <20240302001603.1012084-1-ipylypiv@google.com>
 <20240302001603.1012084-6-ipylypiv@google.com>
 <e363a966-46a6-5c19-ea6c-77db43021149@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e363a966-46a6-5c19-ea6c-77db43021149@huawei.com>

On Sat, Mar 02, 2024 at 10:54:14AM +0800, Jason Yan wrote:
> On 2024/3/2 8:16, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> > ---
> >   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
> >   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
> >   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
> >   3 files changed, 18 insertions(+)
> 
> As John pointed out, please check aic94xx and isci driver, they also use
> libsas.

Thank you, Jason. I wasn't sure about these drivers. Added in v3.

Thanks,
Igor

> 
> Thanks,
> Jason
