From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Wed, 24 Oct 2007 06:18:20 -0400
Message-ID: <471F1BEC.2060701@gmail.com>
References: <20070922131104.GG32509@server.c-otto.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:18678 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbXJXKS2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 06:18:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so126439rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 03:18:27 -0700 (PDT)
In-Reply-To: <20070922131104.GG32509@server.c-otto.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carsten Otto <c-otto@gmx.de>
Cc: linux-ide@vger.kernel.org

Carsten Otto wrote:
> kern.log:Sep 20 00:42:23 server kernel: ata2.00: NCQ disabled due to excessive errors
> 
> Please tell me how I can help resolving the issue (if it is a bug) or,
> if possible, tell me how to fix it myself.
> 
> Information about my system:
> - 4x Maxtor 7V300F0 (MaxLine III, 300GB, 7200rpm, 16MB cache, SATA2),
>   firmware VA111900
> - 1x Samsung 2SP2014N (SpinPoint P, 200GB, 7200rpm, 8MB cache, PATA),
>   firmware VC100-33
> - 4 software RAIDs on the SATA disks, 1x RAID1, 3x RAID5
> - heavy usage of the RAIDs
> - ICH7R
> - 2.6.22.6
> - Pentium D 805, 2GB RAM

Please post dmesg including full boot log and error messages and the 
result of 'hdparm -I /dev/sdX' where sdX are drives which cause such errors.

Thanks.

-- 
tejun
