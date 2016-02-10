From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v4 0/3] ata: Fixes related to edge trigger latch for the ahci_xgene_driver.
Date: Wed, 10 Feb 2016 11:08:27 -0800
Message-ID: <CAOHikRDcChOdP9v2_0a515XAXeG3kZOaLe==mymTJTpmog-6Ow@mail.gmail.com>
References: <1454738124-9351-1-git-send-email-stripathi@apm.com>
	<20160210162547.GJ3741@mtj.duckdns.org>
	<CAOHikRBNL2gLJwhB2SEKJXZtOpmqwBET4P9RgRrPdhyH4bn0zA@mail.gmail.com>
	<20160210190507.GS3741@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34471 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbcBJTI2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Feb 2016 14:08:28 -0500
Received: by mail-yw0-f176.google.com with SMTP id h129so22034274ywb.1
        for <linux-ide@vger.kernel.org>; Wed, 10 Feb 2016 11:08:28 -0800 (PST)
In-Reply-To: <20160210190507.GS3741@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>

Hi Tejun,

On Wed, Feb 10, 2016 at 11:05 AM, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Feb 10, 2016 at 10:59:31AM -0800, Suman Tripathi wrote:
>> Hi Tejun,
>>
>> On Wed, Feb 10, 2016 at 8:25 AM, Tejun Heo <tj@kernel.org> wrote:
>> > On Sat, Feb 06, 2016 at 11:25:21AM +0530, suman Tripathi wrote:
>> >> From: Suman Tripathi <stripathi@apm.com>
>> >>
>> >> This patch set implements a workaround for an errate in the APM
>> >> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
>> >> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
>> >> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
>> >> cycle. It also implements the capability to override generic interrupt
>> >> handler.
>> >
>> > Applied 1-3 to libata/for-4.6 with minor updates.
>>
>> will this patchset  go to 4.5 ?
>
> I applied them to for-4.6 but it can go through for-4.5-fixes if
> necessary.  Is it necessary?

It would be nice because our vendors are using 4.5.

>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
