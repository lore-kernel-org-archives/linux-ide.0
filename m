From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possible data corruption sata_sil24?
Date: Fri, 13 Jul 2007 16:34:06 +0900
Message-ID: <46972AEE.2040805@gmail.com>
References: <20070706012432.GB29789@jabberwocky.com> <4693A5A0.5070306@gmail.com> <20070713014252.GA17811@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:22321 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760659AbXGMHeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 03:34:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so373237nze
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 00:34:14 -0700 (PDT)
In-Reply-To: <20070713014252.GA17811@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello,

David Shaw wrote:
>>> Starting with two 500GB SATA drives (interface card uses a Silicon
>>> 3124 chipset), /dev/sdd and /dev/sde.  I partitioned each into two
>>> 250GB chunks (250*1000*1000*1000, not 250*1024*1024*1024), and set up
>>> two RAID 1 sets such that /dev/md0 is /dev/sdd1+/dev/sde1 and /dev/md2
>>> is /dev/sdd2+/dev/sde2.  I then created a volume group ("storage") on
>>> top of /dev/md0 and /dev/md1.  Finally, I allocated two logical
>>> volumes on top of that: "one" is -L300GB and "two" is -L100GB.
>> -ETOOMANYCOMPNONETS.  If it's data corruption with sata_sil24, it's
>> highly likely that you're gonna be able to regenerate the problem
>> without using raw /dev/sdd and /dev/sde devices.  Please try that.

Oops, sorry, s/without/with/

> It fails whether I use a raw /dev/sdd or partition it into one large
> /dev/sdd1, or partition into multiple partitions.  sata_sil24 seems to
> work by itself, as does dm, but as soon as I mix sata_sil24+dm, I get
> corruption.

Hmmmm.... Can you reproduce the corruption by accessing both devices
simultaneously without using dm?  Considering ich5 does fine, it looks
like hardware and/or driver problem and I really wanna rule out dm.

Thanks.

-- 
tejun
