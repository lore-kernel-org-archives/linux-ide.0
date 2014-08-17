From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] ata: propagate return value of scc_wait_after_reset
Date: Sun, 17 Aug 2014 17:31:53 +0530
Message-ID: <CAJFMrCEdrqWvktexp5nFooz1UdSE4yZ+F15NnaZ5E9p7_z_iqQ@mail.gmail.com>
References: <53ef6157.qX8Csumbm2zNx/EI%fengguang.wu@intel.com>
 <1408198684-2258-1-git-send-email-arjun024@gmail.com> <20140817111042.GN9305@htj.dyndns.org>
 <20140817112705.GO9305@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38361 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaHQMCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2014 08:02:15 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2484923wib.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2014 05:02:13 -0700 (PDT)
In-Reply-To: <20140817112705.GO9305@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 17 August 2014 16:57, Tejun Heo <tj@kernel.org> wrote:
> On Sun, Aug 17, 2014 at 07:10:42AM -0400, Tejun Heo wrote:
>> On Sat, Aug 16, 2014 at 07:48:04PM +0530, Arjun Sreedharan wrote:
>> > scc_bus_softreset not necessarily should return zero.
>> > Propagate the error code.
>> >
>> > Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
>>
>> I reverted the change yesterday but didn't have time to reply.  Don't
>> send patches you haven't even compile tested.  This is the most basic
>> of your responsibilities when sending out patches.  Okay?

Deepest apologies. I had compile tested the first patch; but with a small
variable name change, i overlooked the need to compile test. my fault.

here's the link to the first patch:
https://lkml.org/lkml/diff/2014/8/16/15/1

Also now i feel @err_mask is better.
I rest my case further. Thanks.

>>
>> Applying the updated version to libata/for-3.17-fixes.
>
> Gees, and your new patch doesn't even apply.  What are you doing?
>
> --
> tejun
