From: Mike Cui <cuicui@gmail.com>
Subject: Re: sata_promise fails to detect all 4 HDD on the TX4 since 2.6.26
Date: Wed, 25 Feb 2009 10:05:44 -0800
Message-ID: <7c8826910902251005v5bd37867v6c7f688224e9af3f@mail.gmail.com>
References: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
	 <49A50F20.9060600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:57922 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbZBYSFq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 13:05:46 -0500
Received: by gxk22 with SMTP id 22so330423gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2009 10:05:44 -0800 (PST)
In-Reply-To: <49A50F20.9060600@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

If you want the full kernel boot log I can get it to you in a couple
of days. But here is what I remember from the kernel logs. It probes
each of the 4 ports, and it always thinks that the first port is "link
down". The drives I have plugged into it are samsung HD753LJ


On Wed, Feb 25, 2009 at 1:28 AM, Tejun Heo <tj@kernel.org> wrote:
> Mike Cui wrote:
>> Hi,
>>
>> I tried to update to Ubuntu 8.10 from 8.04 last week, and noticed that
>> after the update the sata_promise driver can no longer detect all 4
>> HDDs that I have plugged into the SATAII300TX4 card. It always reports
>> that the link is down on the first port. I also tried booting a gentoo
>> kernel with 2.6.26, same problem. However, Ubuntu 8.04 with 2.6.25
>> seems fine. Is this a known problem?
>
> Hmm... Can you please install to another disk and try 2.6.28.7 and
> post the kernel boot log if it fails too?
>
> Thanks.
>
> --
> tejun
>
