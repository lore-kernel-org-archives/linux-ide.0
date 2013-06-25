From: Girish KS <girishks2000@gmail.com>
Subject: Re: [PATCH V2] ahci: sata: add support for exynos5440 sata
Date: Tue, 25 Jun 2013 10:05:29 +0530
Message-ID: <CAKrE-KdQCCW1jjkCyh03JWK4mjzSYRtcHcZCc7wi5-y3+CLOhA@mail.gmail.com>
References: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
	<20130617182446.GI32663@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:39449 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3FYEfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2013 00:35:31 -0400
In-Reply-To: <20130617182446.GI32663@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Mon, Jun 17, 2013 at 11:54 PM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Apr 16, 2013 at 02:58:02PM +0530, Girish K S wrote:
>> This patch adds the compatible string of the exynos5440 sata controller
>> compliant with the ahci 1.3 and sata 3.0 specification.
>>
>> Signed-off-by: Girish K S <ks.giri@samsung.com>
>>
>> changes in v2:
>>               changed the compatible string by adding the actual IP
>> owners name instead of the SoC vendor name.
>
> Applied to libata/for-3.11.
>
> Can you please keep SOB at the end of the description after the
> revision history from the next time?

Sure. Thanks

>
> Thanks.
>
> --
> tejun
