From: hab <hab@hbahr.org>
Subject: Re: libata patches in 2.6.7bk6 Hang Maxtor on SP bridge
Date: Tue, 29 Jun 2004 17:35:17 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E1EEA5.7090300@hbahr.org>
References: <40E096B6.8090108@hbahr.org> <20040629082514.GB19267@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:13763 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S266132AbUF2W7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jun 2004 18:59:09 -0400
Received: from mxip05.cluster1.charter.net (mxip05a.cluster1.charter.net [209.225.28.135])
	by mxsf01.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id i5TMxqC3026533
	for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2004 18:59:53 -0400
In-Reply-To: <20040629082514.GB19267@havoc.gtf.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:

>On Mon, Jun 28, 2004 at 05:07:50PM -0500, hab wrote:
>  
>
>>Sir
>>   I resolved problem by baking out scsi portion of patches, athough
>>some general configs such as FC2 development still introduce
>>the same problem as identified in the attached message.
>>    
>>
>
>Use sata_sil not siimage.  And certainly not _both_ drivers.
>
>	Jeff
>
>  
>
Can you think of any others that might cause a conflict.  I had 
inadvertantly left
siimage from a previous compile and starting with a make clean solved 
it.  However
if I take the redhat FC2 development config for i686 even if I leave 
siimage unchecked it
still has the same problem.  siimage was not compiled so it isn't the 
problem.
I will report this to redhat as well.
Thanks
Hubert

>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>

