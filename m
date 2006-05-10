From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem with disk
Date: Thu, 11 May 2006 07:21:29 +0900
Message-ID: <44626769.2000601@gmail.com>
References: <Pine.LNX.4.44.0605061420340.5626-100000@coffee.psychology.mcmaster.ca> <445D29A1.5000402@gmail.com> <445DF445.6070803@emc.com> <445DF911.1020408@gmail.com> <445F56B2.9070300@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:8482 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965044AbWEJWVz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 18:21:55 -0400
Received: by py-out-1112.google.com with SMTP id f28so45192pyf
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 15:21:55 -0700 (PDT)
In-Reply-To: <445F56B2.9070300@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, David.Ronis@McGill.CA, linux-ide@vger.kernel.org, neilb@suse.de

Ric Wheeler wrote:
> I think that MD will do the right thing if the IO terminates with an 
> error condition.  If the error is silent (and that can happen during a 
> write), then it clearly cannot recover.

The condition I've described results in silent loss of data.  Depending 
on type and implementation, LLDD might be able to detect the condition 
(PHY RDY status changed for SATA), but the event happens after the 
affected writes are completed successfully.  For example,

1. fs issues writes for block #x, #y and then barrier #b.
2. #x gets written to the write-back cache and completed successfully
3. power glitch occurs while #y is in progress.  LLDD detects the 
condition, recovers the drive and retries #y.
4. #y gets written to the write-back cache and completed successfully
4. barrier #b gets executed and #y gets written to the media, but #x is 
lost and nobody knows about it.

I'm worried about the problem because, with libata, hotplug is becoming 
available to the masses and when average Joe hot plugs a new drive into 
his machine which has $8 power supply (really, they sell 300w ATX power 
at 8000 KRW which is about $8), this is going to happen.  I had a pretty 
decent power supply from a reputable maker but I still got hit by the 
problem.

Maybe the correct approach is to establish a warm-plug protocol.  Kernel 
provides a way to plug IOs and user helper program plugs all IOs until 
the new device settles.

Thanks.

-- 
tejun
