From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Sat, 16 Feb 2008 12:11:34 +0100
Message-ID: <20080216111134.GA30516@deprecation.cyrius.com>
References: <12029369502995-git-send-email-saeed@marvell.com> <12029369532977-git-send-email-saeed@marvell.com> <47B345A6.9000605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:4861 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbYBPLfv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 06:35:51 -0500
Content-Disposition: inline
In-Reply-To: <47B345A6.9000605@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, nico@cam.org, byron.bbradley@gmail.com

* Mark Lord <mlord@pobox.com> [2008-02-13 14:31]:
>>  	struct device *dev = &pdev->dev;
>>  	struct ata_host *host = dev_get_drvdata(dev);
>> -	struct mv_host_priv *hpriv = host->private_data;
>> -	void __iomem *base = hpriv->base;
>>   	ata_host_detach(host);
>> -	iounmap(base);
>>  	return 0;
>>  }
> ..
>
> Where does the iounmap() now get done instead of that place?

You commented on the 2nd patch but can you please review/ack the 1st
one so this can go in.  Thanks.
-- 
Martin Michlmayr
http://www.cyrius.com/
