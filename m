From: Edward Falk <efalk@google.com>
Subject: Re: Additions to libata patch archive
Date: Wed, 05 Oct 2005 10:47:01 -0700
Message-ID: <43441195.1070707@google.com>
References: <434352E4.8090002@pobox.com> <1128488974.428.16.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-239-45-4.google.com ([216.239.45.4]:5440 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S1030295AbVJERri (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 13:47:38 -0400
In-Reply-To: <1128488974.428.16.camel@camp4.serpentine.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


> In case anyone should care, the original SiImage driver oopses during
> boot with recent kernels.
> 
> The reason I know this is that I just tried booting 2.6.14-rc3 with the
> 0.10 (SiImage) driver.  It appears to contain port multiplier support,
> which I need.  Tejun's rewrite doesn't, and SiImage wants me to sign an
> NDA to get a more recent driver of theirs that has port multiplier
> support.

The original vendor-supplied driver did not support port multipliers, 
but it had the hooks that implied they were thinking about it.  The 
original driver had a number of problems, mostly dealing with lack of 
error recovery as you have just discovered.

Tejun's driver is much better, and I have sent him some patches that 
will make it quite stable.


There are two approaches to port multiplier support -- one is to add it 
to the driver (a real kludge) or to add it to libata.  Kludging it into 
the driver is a quick-and-dirty solution, while adding it to libata will 
take more time.  I'm trying to find the time to do the latter.

	-ed falk
