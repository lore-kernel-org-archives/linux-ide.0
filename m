From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/13] libata-hp: implement hotplug
Date: Tue, 30 May 2006 00:18:46 -0400
Message-ID: <447BC7A6.2070500@pobox.com>
References: <1148884735930-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14820 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751164AbWE3ETN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:19:13 -0400
In-Reply-To: <1148884735930-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
\> +		} else if (dev->class == ATA_DEV_UNKNOWN &&
> +			   ehc->tries[dev->devno] &&
> +			   ata_class_enabled(ehc->classes[dev->devno])) {
> +			dev->class = ehc->classes[dev->devno];
> +
> +			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
> +			if (rc == 0)
> +				rc = ata_dev_configure(dev, 1);
> +
> +			if (rc) {
> +				dev->class = ATA_DEV_UNKNOWN;
> +				break;
> +			}

ACK, with a comment:  It seems like this small snippet of logic appears 
in more than one place, and could be made common

