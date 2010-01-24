From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] hdparm: Fix error in sector offset reporting
Date: Sun, 24 Jan 2010 01:16:33 -0500
Message-ID: <4B5BE5C1.4030703@teksavvy.com>
References: <yq1fx5wwryk.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:18179 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110Ab0AXG1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jan 2010 01:27:41 -0500
In-Reply-To: <yq1fx5wwryk.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

Martin K. Petersen wrote:
> The sector offset reporting is off by a factor of two...
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> diff -urN -X /home/mkp/bin/dontdiff hdparm-9.27.orig/identify.c hdparm-9.27/identify.c
> --- hdparm-9.27.orig/identify.c	2009-08-20 10:31:01.000000000 -0400
> +++ hdparm-9.27/identify.c	2010-01-23 14:07:43.000000000 -0500
> @@ -938,7 +938,7 @@
>  			printf("\t%-31s %11u bytes\n","Physical Sector size:", sector_bytes * pfactor);
>  			if ((val[209] & 0xc000) == 0x4000) {
>  				unsigned int offset = val[209] & 0x1fff;
> -				printf("\t%-31s %11u bytes\n", "Logical Sector-0 offset:", offset * lsize);
> +				printf("\t%-31s %11u bytes\n", "Logical Sector-0 offset:", offset * sector_bytes);
..

Thanks, applied.   I *like* easy fixes like that!

-ml
