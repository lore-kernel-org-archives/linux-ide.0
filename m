From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
Date: Sun, 25 Jun 2006 20:44:14 +0900
Message-ID: <449E770E.4010102@gmail.com>
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:11690 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932388AbWFYLoU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 07:44:20 -0400
Received: by nz-out-0102.google.com with SMTP id z31so1110901nzd
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 04:44:19 -0700 (PDT)
In-Reply-To: <449E73C1.4050604@tomt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andre Tomt wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
> 
> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
> patch, seems to be missing in drivers/scsi/Makefile:

Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
updated tarball is at

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2

Sorry about the trouble.

-- 
tejun
