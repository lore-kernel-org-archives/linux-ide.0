From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 14:51:59 +0900
Message-ID: <43D8637F.5030207@gmail.com>
References: <20060126055050.GA4737@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:148 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751104AbWAZFwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 00:52:05 -0500
Received: by wproxy.gmail.com with SMTP id i3so355465wra
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2006 21:52:05 -0800 (PST)
In-Reply-To: <20060126055050.GA4737@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas.Mailhot@LaPoste.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Nicolas.  Hello, all.
> 
> Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
> (forced-unit-access)thing made into the mainline lately, and it seems
> that your drive is reporting FUA support but doesn't really do it
> properly when it's asked to.
> 
> Can you try the followings to verify the problem?
> 
> 1. make a small partition on the affected drive and do mkfs.ext3 on it.
> 2. mount -o barrier new_partition /mnt/tmp

This should be 'mount -o barrier=1 new_partition /mnt/tmp'

> 3. cd /mnt/tmp; touch asdf; sync


-- 
tejun
