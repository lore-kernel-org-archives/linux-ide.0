From: Tejun Heo <htejun@gmail.com>
Subject: Re: "ata73" == "sd 72" ?
Date: Thu, 24 Apr 2008 12:38:17 +0900
Message-ID: <481000A9.40903@gmail.com>
References: <4807EB94.80104@rtr.ca>	<48083E23.3040505@pobox.com> <18440.22565.901222.300756@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.246]:48298 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750952AbYDXDiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 23:38:24 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1697233rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 20:38:23 -0700 (PDT)
In-Reply-To: <18440.22565.901222.300756@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > Mark Lord wrote:
>  > > While working on sata_mv today, I noticed something weird in the syslog.
>  > > The messages from libata show "ata73" for the port with my drives (pmp),
>  > > but the messages from SCSI (sd) show "sd 72" for those same drives.
>  > > 
>  > > One would really think that these two numbers should agree,
>  > > not be off by one.  I wonder why they differ (or why they are
>  > > almost the same) ?
>  > 
>  > Just historical reasons, one counts from zero and the other does not...
> 
> Could this possibly be changed, please? I've noticed this
> discrepancy myself and it really is confusing.
> 
> Maybe the mapping exists in sysfs, but navigating sysfs is
> an absolute nightmare IMO so I wouldn't know how to find it.

I hope it could be changed too but it can also irritate a lot of people. 
  :-(

-- 
tejun
