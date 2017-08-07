From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ata: make ata_port_operations const
Date: Mon, 7 Aug 2017 20:54:21 +0530
Message-ID: <CAOH+1jEQy3PrExruDLWetVd=iWYX3sf13Ku5G5CUUbJGADsNvw@mail.gmail.com>
References: <1502101922-13313-1-git-send-email-bhumirks@gmail.com> <20170807150727.GD4050379@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35135 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdHGPYX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2017 11:24:23 -0400
In-Reply-To: <20170807150727.GD4050379@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 7, 2017 at 8:37 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Mon, Aug 07, 2017 at 04:02:02PM +0530, Bhumika Goyal wrote:
>> Make ata_port_operations structures const as it is only stored in the
>> inherits field of an ata_port_operations structure. Therefore make it
>> const.
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>
> How did you test the patch?
>

I compiled the .o files and checked the size before and after
compilation. After making the structure const, bytes should move from
data to text segment of the memory and this is what happened. So, this
is how I tested it.

Thanks,
Bhumika

> Thanks.
>
> --
> tejun
