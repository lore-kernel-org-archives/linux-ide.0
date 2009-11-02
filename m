From: Thomas Abraham <thomas.ab@samsung.com>
Subject: Re: [PATCH 2/7] S3C64XX: Add MEM_SYS_CFG register definition.
Date: Mon, 2 Nov 2009 15:11:15 +0900
Message-ID: <84c135f50911012211m47f1c36ie4a94212a7f5447c@mail.gmail.com>
References: <1257051031-8074-1-git-send-email-thomas.ab@samsung.com>
	 <20091101130228.GH8096@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:37479 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZKBGLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Nov 2009 01:11:10 -0500
Received: by pzk26 with SMTP id 26so3055963pzk.4
        for <linux-ide@vger.kernel.org>; Sun, 01 Nov 2009 22:11:15 -0800 (PST)
In-Reply-To: <20091101130228.GH8096@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 1, 2009 at 10:02 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:50:31PM +0900, Thomas Abraham wrote:
>> This patch adds the definition of MEM_SYS_CFG register for
>> S3C64xx platform.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>> =A0arch/arm/plat-s3c64xx/include/plat/regs-clock.h | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/=
arm/plat-s3c64xx/include/plat/regs-clock.h
>> index 2c3224c..ad0823e 100644
>> --- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
>> +++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
>> @@ -15,6 +15,8 @@
>> =A0#ifndef __PLAT_REGS_CLOCK_H
>> =A0#define __PLAT_REGS_CLOCK_H __FILE__
>>
>> +#include <plat/map-base.h>
>> +
>
> Why are you adding <plat/map-base.h> here?
>

I will remove it. That was a mistake.
