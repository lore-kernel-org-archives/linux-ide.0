From: Tejun Heo <htejun@gmail.com>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv
Date: Mon, 30 Apr 2007 12:04:58 +0200
Message-ID: <4635BF4A.3050509@gmail.com>
References: <46351BE2.70901@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:6541 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030939AbXD3Tu2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 15:50:28 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2031854nzf
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 12:50:27 -0700 (PDT)
In-Reply-To: <46351BE2.70901@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Stefan wrote:
> Hi folks,
> 
> yesterday I upgraded  kernel 2.6.19 to 2.6.20 (gentoo kernel). Now my
> box locks up about 10 min after boot.
> After that I tested with a vanilla 2.6.21.1 it shows the same behavior.
> I'm attaching a kern log file from the 2.6.20. The 2.6.21.1 locked up so
> hard, that there was no trace left in the log file.
> If I switch back to 2.6.19 everything is fine again.
> If necessary I will hook up a laptop to this box, so I can capture
> messages via netconsole.

Yes please.

> This machine is running an AMD X2 64, NFORCE4 (ASUS A8N-E)
> 
> I haven't been following the development of libata for a while, but from
> the 2.6.20 changelog It looks like there have been some major changes.
> 
> Just let me know what kind of information you need in order to narrow it
> down.

Does giving 'sata_nv.adma=0' kernel parameter make any difference?

-- 
tejun

