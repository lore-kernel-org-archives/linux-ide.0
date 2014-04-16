From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Wed, 16 Apr 2014 16:16:13 -0400
Message-ID: <20140416201613.GI22569@htj.dyndns.org>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:54937 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbaDPUQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 16:16:17 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so12431826qcx.38
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2014 13:16:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

Hello,

On Tue, Apr 01, 2014 at 08:42:36PM -0400, Martin K. Petersen wrote:
> +static ssize_t
> +show_ata_dev_trim(struct device *dev,
> +		  struct device_attribute *attr, char *buf)
> +{
> +	struct ata_device *ata_dev = transport_class_to_dev(dev);
> +	unsigned int mode;

Let's please just do

	const char *mode = "unsupported";

	if (ata_id_has_trim(ata_dev->id)) {
		if (ata_fpdma_dsm_supported(ata_dev))
			mode = "queued";
		else
			mode = "unqueued";
	}

	return sprintf(buf, "%s\n", mode);

Thanks.

-- 
tejun
