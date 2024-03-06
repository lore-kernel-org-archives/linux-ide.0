Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F81BDD8
	for <linux-ide@vger.kernel.org>; Wed,  6 Mar 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759837; cv=none; b=UYbE6xk5JEhewdTcmP4UZQFEdgG5A05BPoZNmQZT2Hl4p6xDMUZsWhKasSJnLMixnS+1sR5GgXuYJ/+ROQyHDfedxDBtIqYmRECM2u8KGHexuLP5NquRkJ1QF26OZfWrEJtYe0I7zXB3bbqcXsTxNj5Wkyk93p056+R7xe5+8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759837; c=relaxed/simple;
	bh=3NYFhhT01FUdEcyk+FnkfBgB4GczQeG+bfnl3/XptWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je6XsK9/sZWKcg/UdgtbApzGsMDo6tKHXn65w369JaoRd1Vy6qtC+VWoPzLC3CcqrbVBI1r59pAz7DuMZTciob1c8aIFe7P9F8qgH3+K+gvCow3TCeyA4OhgVJ/uKSZ/i8o8RBfrQaJn3w8LeVSdqOnl/LtWqkAabbFsSNjeXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKntrcrH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKntrcrH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6568e169aso219832b3a.0
        for <linux-ide@vger.kernel.org>; Wed, 06 Mar 2024 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709759835; x=1710364635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9gHAsTorGntNJmsyBdgcnCbH71WEgz640QlCNFHUk=;
        b=PKntrcrH1irgrX987JWAHieaLDt8cPQ5L1IhE2b5R/iBxhdKzmDfYUtfJNKBEMk1wY
         HsCZ1AZO5dmlcRkoOCCC8W+QSzmYuFqwSoIXm29oYv1SQdcCsB0thJSAGX6TIjmeHMq8
         qPRXNV9u5krJFkBQ9w7AgECC9HDns3pLFD1/g1dtRQAIBTf0B9brnb8iYAk8+VsYqlJ8
         K0/1LKlhpA0Lwt4TJoV4Xsz9R/pTyHAni9ZIQIMDZT6gyWwsdhvO2IZvDQbMWxkvP0DK
         20AWF4Y5E3I4tEarRVp1PwDE3RIc34z91gnuS8taWxiE8LjoysF8BwVkp7EG0/HxIEb+
         cNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759835; x=1710364635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p9gHAsTorGntNJmsyBdgcnCbH71WEgz640QlCNFHUk=;
        b=ivV5kp6Mf3Zr8spe6hR4Q3W5tfekBs+Lda3JzRqkxz9qWAutLeOWDbd5w5uYRtrpb9
         XQnPLUm/SNhxa8OaPa+F9qvydxHrBt2qBDgUwBVrvwGPxorzXDzHv7QfDq4R+6//d2tZ
         HVw42Z50OeugXwtxkmGAT6Bqe6r4tcz6msVzkdRzwUIqcVooccNCMbg5fXEBEI+I7mmz
         aDFN6Xl40x1Y+XeL5oyM144IyuK7GZnNH5OFhj3ibrcKMZTmuXAkWe66Z/tAWixVpdI8
         Wp5YEOR+r3+HR1PqaKhnFJ+DFQ1KSroq6EDRdm/G17F07JrncjLSwx69h4EE3NRFFds0
         d/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvM5ub/24tWN/BNzIiJFJTB/wZDEW3pjwDwyZw0YAqOTVYfOrLq+F7sjntSD1fUW+qA2bEKD6SzUeFCj0+QWE6m01XSZrQvuw
X-Gm-Message-State: AOJu0Yw7mVeEm8taRwMXHn1oIMqCTvTzolCoWdKNGK8PVlbK+Epn9Su2
	VRepRnuFd0CnhX6OQTqqB+JbtOshhpQUsucYWYhXvAyLMdP0WFJcZnl42QnG9A==
X-Google-Smtp-Source: AGHT+IGnCnXNELiWj2GKO9e4qKNcy/GwrMnsxai7rAjNDTDS3b/TSac5QWwhDKfPUHjJfQdoYw8CEA==
X-Received: by 2002:a05:6a20:394f:b0:1a1:4e6b:185f with SMTP id r15-20020a056a20394f00b001a14e6b185fmr7143741pzg.25.1709759834701;
        Wed, 06 Mar 2024 13:17:14 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:9a91:c17:53d9:d156])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11174635pfl.66.2024.03.06.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:17:14 -0800 (PST)
Date: Wed, 6 Mar 2024 13:17:09 -0800
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
Subject: Re: [PATCH v7 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Message-ID: <ZejdVf4fHVUPkMGr@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-7-ipylypiv@google.com>
 <ZehLtGYczWmIvcwy@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehLtGYczWmIvcwy@ryzen>

On Wed, Mar 06, 2024 at 11:55:48AM +0100, Niklas Cassel wrote:
> On Tue, Mar 05, 2024 at 05:22:25PM -0800, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
> > index 8a3340d8d7ad..ccccd0eb6275 100644
> > --- a/drivers/scsi/aic94xx/aic94xx_init.c
> > +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/firmware.h>
> >  #include <linux/slab.h>
> >  
> > +#include <scsi/sas_ata.h>
> >  #include <scsi/scsi_host.h>
> >  
> >  #include "aic94xx.h"
> > @@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
> >  static struct scsi_transport_template *aic94xx_transport_template;
> >  static int asd_scan_finished(struct Scsi_Host *, unsigned long);
> >  static void asd_scan_start(struct Scsi_Host *);
> > +static const struct attribute_group *asd_sdev_groups[];
> >  
> >  static const struct scsi_host_template aic94xx_sht = {
> >  	.module			= THIS_MODULE,
> > @@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
> >  	.compat_ioctl		= sas_ioctl,
> >  #endif
> >  	.track_queue_depth	= 1,
> > +	.sdev_groups		= asd_sdev_groups,
> >  };
> >  
> >  static int asd_map_memio(struct asd_ha_struct *asd_ha)
> > @@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
> >  	driver_remove_file(driver, &driver_attr_version);
> >  }
> >  
> > +static const struct attribute_group *asd_sdev_groups[] = {
> > +	&sas_ata_sdev_attr_group,
> > +	NULL
> > +};
> 
> If you move this in front of:
> static const struct scsi_host_template aic94xx_sht = { };
> 
> I think that you can remove the forward declaration.
> 

Same comment as for mvs_sht. Perhaps mvs_sht can be moved to the bottom
of the file (in a separate patch series) so that all forward declarations
can be removed?

> 
> > +
> >  static struct sas_domain_function_template aic94xx_transport_functions = {
> >  	.lldd_dev_found		= asd_dev_found,
> >  	.lldd_dev_gone		= asd_dev_gone,
> > -- 
> > 2.44.0.278.ge034bb2e1d-goog
> > 
