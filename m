Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96630324B34
	for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2026 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516465; cv=none; b=VehLA+hV/rNmZgvVweUJU2K82QKC1VAolgR3kMm5TqFE/28CQL5oCYdU7O6IUwAjjD/2a/w2npMqksTia1ZjXpj0pe6Bk8w/4Fqw20WlQF0KAmsLDbm/a1iqSh7mpEVerShMJ3nzUA1Tq4o0QIoZWRsOeYQ0mDeE9pHoAxGHT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516465; c=relaxed/simple;
	bh=KjAlPEth4Kr7fEHcdRZ5AgXc4ovOuTwX7cWLc24agZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THAOQf7uaLuMTj3pij89Pc3zfiZjjSE0ABMEuLelq26uYW5BgRDesb0QnvCQWbiZXLX5R1+2B3Our+wjPvfZTIgn6UpxfKhzCoIishNiDXZeTji12V07dJKnx6n11DS5IMeCbIL75pCKcujlGcAdB14TizCxCJ1vE/H7ZS6vuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkTvRzsu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkTvRzsu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a35ae38bdfso9435ad.1
        for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2026 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768516463; x=1769121263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJALzZttJCf8zJO60CKi5L33ydZ1YJ1ewt2BEqKTx8I=;
        b=rkTvRzsuWSi+3HWX5IVRZbqF0Zp91aaQUsFMPsOREZhmjY3uhWxykfLr8TfBNx8CWT
         qHZZUeOfJ2RvCsyeDCTrWOAj/kYHZ7OcYckduWfMzlwPSKbJ6xYxYF8tPTt/ar0OMeay
         nrNYCdSpElGywcZih3YATBGCqcWQ5USxk62DlpvsS3fAPJMzNgYHRswtlC9LzaVqAQ6m
         RPzc0RwLp7U1msNUVCYBGJT9C+MQpwPUY+6BpUHWmCGaDDb71CZ9BtDpwhUOqssa4Dy+
         fC1Y/7PZ+oNRC+lTQdLAWBRzNs8IRdSHsyA7h35tCvwOkwsS8/Hr75fZLn9kXIbsY74n
         qQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516463; x=1769121263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJALzZttJCf8zJO60CKi5L33ydZ1YJ1ewt2BEqKTx8I=;
        b=v8zgYXfcdXZ16Xg/DwdEe7pfuIfSJDRax+GYDZ+M6kg3bcSSLqcWn4uizcTQSTij7F
         OKCnIiE2teHq/lhTSNgI8I1Hj4iPC1RmpIMH7DxaxddJktsGXR19eRhBtFyTrqwL7K76
         oY30ypz813TDpipnz5LF50LRtgwfGH/K0DDQ1OxsbtGxiCSh2lVafZh40aUhnPitcINp
         5XPGYOM66YbEzRuOlHJ8mcqncmzt1EFivn08ToN46etc191A0Nj63hKDbeNjImmf8ujR
         PZjNXTUml4QrCYfIG199s4slmlaShfBNCsGw5ttwecJSh5t0sIbECZvPzF5iUNyRjWLd
         hkGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0wURCrs6rdtgxR57D9MJ1NxSPLAZH/1NoJx4JVlNrOpaY7kp4ACtZJF50xJVDN2eyn45n16G5eDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj53eZ8NhDE22eViwL3quni+erzmS7es+zMVdLY53j7L8rt+ug
	bESmVmukJQW4woMJCbEZlovKGPjORt8HEY+NbWy+fU6b9ApwmY4k5qB5VkKvJYDg15LkORvDwkm
	YURNQTQ==
X-Gm-Gg: AY/fxX7Msz5jjIosPmVlWfYrRvBOLwpy3vvY2Aguogu8RIq85vbeeCSzSQ0RSQCydwb
	KtmH+rBV6c3pD3bwmZXDkmbmVyDKCWeV3nP7dgnrwgN4VYHzAztg2drQ9e2Tvhbs4RQZzH5exdn
	+BVBOqS2perTlrY+9mlI5ulgyNzJRZ36UQXPHK9bu+Dm27QLLt811+gfGMPLFRseeiGTsmN4EGu
	exVvXoE3cj9Nrn20ASVFD23+/SW3Zpa5XcaYgvhaYEFrfJfhqVoF5P87hqGvab4upLf9EjYDEcp
	cNKpRf1GXfWPgl5hEMIh02PhVlR399b3xRfrdN14a8mwn3+oSjeek7Kuc09OhmriFgpttCiEZvn
	XncDOpwacjCVZTpUI5K4DjMOeIiZsvkyXbK7HfboWMPJE+s54g9seWSUuUZJ8+vtzYcJeP0BkeY
	UMgmVTOWeuF/q+eErSxDMVfrvEH5Zl/ar7i+TcGjwKP0vxwatZuA==
X-Received: by 2002:a17:902:d2d0:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2a71ada6b7dmr366875ad.7.1768516462467;
        Thu, 15 Jan 2026 14:34:22 -0800 (PST)
Received: from google.com (185.29.127.34.bc.googleusercontent.com. [34.127.29.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbed7sm2752375ad.63.2026.01.15.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:34:22 -0800 (PST)
Date: Thu, 15 Jan 2026 14:34:18 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Add 'serial' sysfs attribute for SCSI/SATA
Message-ID: <aWlranMwrCSV7Yi5@google.com>
References: <20260114175115.384741-1-ipylypiv@google.com>
 <ce30b2fe-8225-47fb-b581-251a1b9cd2cf@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce30b2fe-8225-47fb-b581-251a1b9cd2cf@acm.org>

On Wed, Jan 14, 2026 at 12:40:16PM -0800, Bart Van Assche wrote:
> On 1/14/26 10:51 AM, Igor Pylypiv wrote:
> > Add a 'serial' sysfs attribute for SCSI and SATA devices. This attribute
> > exposes the Unit Serial Number, which is derived from the Device
> > Identification Vital Product Data (VPD) page 0x80.
> > 
> > Whitespace is stripped from the retrieved serial number to handle
> > the different alignment (right-aligned for SCSI, potentially
> > left-aligned for SATA). As noted in SAT-5 10.5.3, "Although SPC-5 defines
> > the PRODUCT SERIAL NUMBER field as right-aligned, ACS-5 does not require
> > its SERIAL NUMBER field to be right-aligned. Therefore, right-alignment
> > of the PRODUCT SERIAL NUMBER field for the translation is not assured."
> > 
> > This attribute is used by tools such as lsblk to display the serial
> > number of block devices.
> 
> How can existing user space tools use a sysfs attribute that has not yet
> been implemented? Please explain.


The 'serial' sysfs attribute is implemented for NVMe. Since 'serial' sysfs
attribute is missing for SCSI/SATA devices, lsblk reports an empty string
instead of a serial number.

# lsblk --nodeps -o name,serial
NAME    SERIAL
sda     
sdb     

> 
> > +int scsi_vpd_lun_serial(struct scsi_device *sdev, char *sn, size_t sn_size)
> > +{
> > +	int len;
> > +	const unsigned char *d;
> > +	const struct scsi_vpd *vpd_pg80;
> 
> The current convention for declarations in Linux kernel code is to order
> these from longest to shortest. In other words, the opposite order of
> the above order.
>

Thanks for pointing this out. I'll reorder the declarations in V2.
 
> > +	rcu_read_lock();
> 
> Please use guard(rcu)() in new code.

Thanks. I'll fix this in V2.
 
> > +	vpd_pg80 = rcu_dereference(sdev->vpd_pg80);
> > +	if (!vpd_pg80) {
> > +		rcu_read_unlock();
> > +		return -ENXIO;
> > +	}
> > +
> > +	len = vpd_pg80->len - 4;
> > +	d = vpd_pg80->data + 4;
> > +
> > +	/* Skip leading spaces */
> > +	while (len > 0 && isspace(*d)) {
> > +		len--;
> > +		d++;
> > +	}
> > +
> > +	/* Skip trailing spaces */
> > +	while (len > 0 && isspace(d[len - 1]))
> > +		len--;
> > +
> > +	if (sn_size < len + 1) {
> > +		rcu_read_unlock();
> > +		return -EINVAL;
> > +	}
> 
> Has it been considered to call strim() instead of implementing functionality
> that is very similar to strim()?

Yes, I considered using strim(). strim() modifies the input buffer by
replacing first trailing whitespace with '\0' so we can't use it directly
on the vpd_pg80->data. The solution would be to copy the whole vpd page
data into the sn buffer and call strim() on the sn buffer. strim() returns
a pointer to the first non-whitespace character so we would also need to
memmove the serial number to the beginning of the sn buffer. All this extra
copying seems to be redundant so I went ahead with a simpler solution
that does a single memcpy().

> > +	return sysfs_emit(buf, "%s\n", buf);
> 
> The C99 standard says that passing the output buffer pointer as an argument
> to sprintf()/snprintf() triggers undefined behavior. I'm not sure whether
> this also applies to the kernel equivalents of these
> functions but it's probably better to be careful.

Kernel implementation of sysfs_emit() seems to be fine. The documentation
states that sysfs_emit()/sysfs_emit_at() should be used for show() methods.

https://github.com/torvalds/linux/blob/603c05a1639f60e0c52c5fdd25cf5e0b44b9bd8e/Documentation/filesystems/sysfs.rst?plain=1#L246-L247

Thanks,
Igor

> Thanks,
> 
> Bart.
