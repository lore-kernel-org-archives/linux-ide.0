From: Tejun Heo <htejun@gmail.com>
Subject: Re: slow resume from s2ram
Date: Wed, 06 Feb 2008 15:49:24 +0900
Message-ID: <47A95874.60601@gmail.com>
References: <20080205130931.56F31E2B10@vilya.x>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:7610 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759368AbYBFInd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 03:43:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1885292rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 00:43:32 -0800 (PST)
In-Reply-To: <20080205130931.56F31E2B10@vilya.x>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Keck <bwkeck@gmail.com>
Cc: linux-ide@vger.kernel.org

Brian Keck wrote:
> Hello,
> 
> I can't get my otherwise lovely debian/sid Vaio TX17 to resume promptly
> from suspend-to-ram.
> 
> Until recently it resumed at all maybe 1 in 4 times from
> 's2ram -f -p' in X, always taking several minutes, apparently 
> due to the hard disk (1.8" Toshiba HDD1544/MK6006GAH).   
> 
> Last week I tried 2 things:
> 
>   * added /etc/modprobe.d/libata with
>     options libata noacpi=0
> 
>   * built a kernel + initrd from debian linux-source-2.6.24 with
>     CONFIG_BLK_DEV_IDEACPI=y
> 
> This boots OK, with ...
> 
>    $ cat /sys/module/libata/parameters/noacpi
>    0

You're not using libata at all.  You're using IDE driver instead.
Please try libata ata_piix driver instead.

-- 
tejun

