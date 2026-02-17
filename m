Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3636E496
	for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347492; cv=none; b=rnfPPaEdpV9FM7PQZFgaLf+zIanHFh8Mq+qXVFi/VQw2EQUCDrJ+dCIpgqGM9uaGbaGtV6o/Ko9aI2iMDABF5S2YrwxqDQ2xXz5TpFsqaxIUCE9cCB4E9AnBKcG5dp9F/FbQf7FxNduRKi+KRpuWjUwzpVo+/SI7G9galLcktR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347492; c=relaxed/simple;
	bh=ieXwuS9RqKG5AbDgk6zK3Sz/gDnf1qgIn0zAze1pTE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av25VSeY2+myvOs1Y4iI5zerrSnwoDkcE3SE5Wd2jnk2dmZ3owd8KyXKyQbA5Ntsom85hiupKVh5+bGSj9HpLgu7zDIuqg8/7ZcdT/Oebc7FplB4OwtqsElPiD118UqSe5pqffPVwP5Q3sNw/X0VplSVLQNw2eFd+brLS1L8HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4HIGJeI1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4HIGJeI1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a885af8ee7so209025ad.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2026 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771347490; x=1771952290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XlBGe6Nd5IhwkGo2tJT1WGLgnhboDh9a8xjyQWZ5EZg=;
        b=4HIGJeI1p4U2u1W7AnWPETiuTNRVFOj4/Tcf7KClz9NCMrLteZfK86yP4g9uzjXzd4
         HQfrS5xh7Z7FQI1ivcPvcxUGoAuoEIGd8lPEqEy4vLyAAR4AjJQM4WSscA5qDElgHGZC
         SyyBMpypydYZOpwFgRL6Jwo2AxwFQezoIRvdeG0epXEvImLWCGh2LWk/abqtjeBTSa5G
         x4/XrOzlt3MMFZ5NPjFDhlHGR/ahcxMkIL36j4pRN0LCBOpMgJw0x4HX7J7dGjTWoVaj
         ytosGwDDJU2VuqNYBl0XjfFuRoeexOkxw41ICqnmQM33R5VmHvQcr70bFQfOoSEdfbup
         c1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771347490; x=1771952290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlBGe6Nd5IhwkGo2tJT1WGLgnhboDh9a8xjyQWZ5EZg=;
        b=qmz7K8FGa11AmTEio3pTTnGO+ka6/B4rzdlFROM894XOzvcubMRQUbmA3t0cUHLypT
         B5AyaDQ8YoDIkpVo1Lj+SPXlbcr8o96FE96PNl6lH3hKS2MS/FKOv+FBO6aEPogshebE
         /LodbmAvGfaHPX3Y0SdJcTrLJ69jjFGI3XaqtfQ/noDuuAUbO9gkdkvxf20kdBx1w9gL
         fTSQ08ISvOcbv2exGZxi7N3yZHQYE862QWXbOjbu7wetqpVHEprQoF7o7tu/nQUEvkae
         ehLoBiq04b0k9YVog7phRrmGBkIoe8qlzc8kXNO88btTWiwEkcW/LQGu9L+kMsJr8ji4
         oSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWlcyXAD2T/TwSCK1XUgNyv+bpmhADtaNW46EZphvBmWautmJ6TYtirZIojYMLVjlC1223aDSd9no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSL9ujpp+wAC/Gf19pSZj1WSHE+bHMSt5/nGTaymIjzPn1Oz61
	WnDPc/RFqkaUQtuMaRUm9BMzLKRM2hv4OC+IEPY47bbonWhdkQBaTfwbr7QFcls2zg==
X-Gm-Gg: AZuq6aJmFZ4c8rAspEfJ8xzQCL+31a3CvLYwFvb+rxwbXfBCW8C/CMTXBOIbwKEImpZ
	816myLwLbagD1rnfQdl+3p31quepM8KNs5mdSv+AbEUTYWzyoAItXgeh+6yMMdefmAyHeGli8AN
	+MWIT0vcV36wxm5sEEQq3plfjaSYuY7syMiWYDlYisDHBQdmvyeKlvALVMesZyFIpGIK82pXQt+
	8W85m0+2PtE2xydzyU/RWpKiZWmZY+bjpFhPDpa1NOJttN763F0axjgrsV9dKrm+fE9bl7tDyRt
	qIw5s6PD/pAhgXPDX0lI+x8aCv/Xhu4pQiYh5VMGLrDEzNzXNxD8Nitv5FOqYCUSjUKGih2AAp6
	6K8YA3WapNCztRt6pvgB9r4NzrkNCj/7gU3FcFaCiRWkTzq8D5eYMBVRj6//gk1OYT/Z9mr2pCq
	2dW5ez2egOV2J2f0A+41yVvxGNEEq1I8qwBSnRdU4zyp6Kn/pWk4XvwPXxnRNdeA==
X-Received: by 2002:a17:902:8216:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2ad36c912c4mr2366405ad.13.1771347489590;
        Tue, 17 Feb 2026 08:58:09 -0800 (PST)
Received: from google.com (185.29.127.34.bc.googleusercontent.com. [34.127.29.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9da8a2sm19378161a91.5.2026.02.17.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:58:08 -0800 (PST)
Date: Tue, 17 Feb 2026 08:58:04 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: core: Add 'serial' sysfs attribute for SCSI/SATA
Message-ID: <aZSeHCH-IOjqw2n3@google.com>
References: <20260209212151.342151-1-ipylypiv@google.com>
 <d61a1830-d9d0-4697-b547-80106ce57023@suse.de>
 <aYtiDLvRotCE0hEt@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYtiDLvRotCE0hEt@google.com>

On Tue, Feb 10, 2026 at 08:51:24AM -0800, Igor Pylypiv wrote:
> On Tue, Feb 10, 2026 at 12:38:51PM +0100, Hannes Reinecke wrote:
> > On 2/9/26 22:21, Igor Pylypiv wrote:
> > > Add a 'serial' sysfs attribute for SCSI and SATA devices. This attribute
> > > exposes the Unit Serial Number, which is derived from the Device
> > > Identification Vital Product Data (VPD) page 0x80.
> > > 
> > > Whitespace is stripped from the retrieved serial number to handle
> > > the different alignment (right-aligned for SCSI, potentially
> > > left-aligned for SATA). As noted in SAT-5 10.5.3, "Although SPC-5 defines
> > > the PRODUCT SERIAL NUMBER field as right-aligned, ACS-5 does not require
> > > its SERIAL NUMBER field to be right-aligned. Therefore, right-alignment
> > > of the PRODUCT SERIAL NUMBER field for the translation is not assured."
> > > 
> > > This attribute is used by tools such as lsblk to display the serial
> > > number of block devices.
> > > 
> > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > ---
> > > 
> > > v2->v3 changes:
> > > - Replaced sysfs_emit(buf, "%s\n", buf) with a manual newline placement
> > >    to avoid undefined behavior of passing the output buffer as an input.
> > > 
> > > v1->v2 changes:
> > > - Reordered declarations in scsi_vpd_lun_serial() from longest to shortest.
> > > - Replaced rcu_read_lock()/rcu_read_unlock() with guard(rcu)().
> > > 
> > > 
> > >   drivers/scsi/scsi_lib.c    | 47 ++++++++++++++++++++++++++++++++++++++
> > >   drivers/scsi/scsi_sysfs.c  | 16 +++++++++++++
> > >   include/scsi/scsi_device.h |  1 +
> > >   3 files changed, 64 insertions(+)
> > > 
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index 4a902c9dfd8b..c17fbe4dd845 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -13,6 +13,7 @@
> > >   #include <linux/bitops.h>
> > >   #include <linux/blkdev.h>
> > >   #include <linux/completion.h>
> > > +#include <linux/ctype.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/export.h>
> > >   #include <linux/init.h>
> > > @@ -3459,6 +3460,52 @@ int scsi_vpd_lun_id(struct scsi_device *sdev, char *id, size_t id_len)
> > >   }
> > >   EXPORT_SYMBOL(scsi_vpd_lun_id);
> > > +/**
> > > + * scsi_vpd_lun_serial - return a unique device serial number
> > > + * @sdev: SCSI device
> > > + * @sn:   buffer for the serial number
> > > + * @sn_size: size of the buffer
> > > + *
> > > + * Copies the device serial number into @sn based on the information in
> > > + * the VPD page 0x80 of the device. The string will be null terminated
> > > + * and have leading and trailing whitespace stripped.
> > > + *
> > > + * Returns the length of the serial number or error on failure.
> > > + */
> > > +int scsi_vpd_lun_serial(struct scsi_device *sdev, char *sn, size_t sn_size)
> > > +{
> > > +	const struct scsi_vpd *vpd_pg80;
> > > +	const unsigned char *d;
> > > +	int len;
> > > +
> > > +	guard(rcu)();
> > > +	vpd_pg80 = rcu_dereference(sdev->vpd_pg80);
> > > +	if (!vpd_pg80)
> > > +		return -ENXIO;
> > > +
> > > +	len = vpd_pg80->len - 4;
> > > +	d = vpd_pg80->data + 4;
> > > +
> > > +	/* Skip leading spaces */
> > > +	while (len > 0 && isspace(*d)) {
> > > +		len--;
> > > +		d++;
> > > +	}
> > > +
> > > +	/* Skip trailing spaces */
> > > +	while (len > 0 && isspace(d[len - 1]))
> > > +		len--;
> > > +
> > 
> > Please use 'strim()' instead.
> 
> Hi Hannes,
> 
> Bart pointed this out in V1 as well. I'll copy-paste my reply from V1:
> 
> "Yes, I considered using strim(). strim() modifies the input buffer by
> replacing first trailing whitespace with '\0' so we can't use it directly
> on the vpd_pg80->data. The solution would be to copy the whole vpd page
> data into the sn buffer and call strim() on the sn buffer. strim() returns
> a pointer to the first non-whitespace character so we would also need to
> memmove the serial number to the beginning of the sn buffer. All this extra
> copying seems to be redundant so I went ahead with a simpler solution
> that does a single memcpy()."
> 
> Please let me know your thoughts on this.

Hi Hannes,

Ping for a feedback.
Sending this in case my previous reply fell through the cracks.

Thank you!
Igor

> 
> > 
> > > +	if (sn_size < len + 1)
> > > +		return -EINVAL;
> > > +
> > > +	memcpy(sn, d, len);
> > 
> > 'len' might well be '0' after 'strim()', please check
> > before calling 'memcpy'.
> 
> It looks like calling a memcpy() with zero length is a no-op. Is checking
> for len > 0 really necessary in this case?
> 
> Thank you,
> Igor
> 
> > > +	sn[len] = '\0';
> > > +
> > > +	return len;
> > > +}
> > > +EXPORT_SYMBOL(scsi_vpd_lun_serial);
> > > +
> > >   /**
> > >    * scsi_vpd_tpg_id - return a target port group identifier
> > >    * @sdev: SCSI device
> > > diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> > > index 99eb0a30df61..9c4f47e7a298 100644
> > > --- a/drivers/scsi/scsi_sysfs.c
> > > +++ b/drivers/scsi/scsi_sysfs.c
> > > @@ -1013,6 +1013,21 @@ sdev_show_wwid(struct device *dev, struct device_attribute *attr,
> > >   }
> > >   static DEVICE_ATTR(wwid, S_IRUGO, sdev_show_wwid, NULL);
> > > +static ssize_t
> > > +sdev_show_serial(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct scsi_device *sdev = to_scsi_device(dev);
> > > +	ssize_t ret;
> > > +
> > > +	ret = scsi_vpd_lun_serial(sdev, buf, PAGE_SIZE);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	buf[ret] = '\n';
> > > +	return ret + 1;
> > > +}
> > > +static DEVICE_ATTR(serial, S_IRUGO, sdev_show_serial, NULL);
> > > +
> > >   #define BLIST_FLAG_NAME(name)					\
> > >   	[const_ilog2((__force __u64)BLIST_##name)] = #name
> > >   static const char *const sdev_bflags_name[] = {
> > > @@ -1257,6 +1272,7 @@ static struct attribute *scsi_sdev_attrs[] = {
> > >   	&dev_attr_device_busy.attr,
> > >   	&dev_attr_vendor.attr,
> > >   	&dev_attr_model.attr,
> > > +	&dev_attr_serial.attr,
> > >   	&dev_attr_rev.attr,
> > >   	&dev_attr_rescan.attr,
> > >   	&dev_attr_delete.attr,
> > > diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> > > index d32f5841f4f8..9c2a7bbe5891 100644
> > > --- a/include/scsi/scsi_device.h
> > > +++ b/include/scsi/scsi_device.h
> > > @@ -571,6 +571,7 @@ void scsi_put_internal_cmd(struct scsi_cmnd *scmd);
> > >   extern void sdev_disable_disk_events(struct scsi_device *sdev);
> > >   extern void sdev_enable_disk_events(struct scsi_device *sdev);
> > >   extern int scsi_vpd_lun_id(struct scsi_device *, char *, size_t);
> > > +extern int scsi_vpd_lun_serial(struct scsi_device *, char *, size_t);
> > >   extern int scsi_vpd_tpg_id(struct scsi_device *, int *);
> > >   #ifdef CONFIG_PM
> > 
> > Otherwise looks okay.
> > 
> > Cheers,
> > 
> > Hannes
> > -- 
> > Dr. Hannes Reinecke                  Kernel Storage Architect
> > hare@suse.de                                +49 911 74053 688
> > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> > HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
