From: Thomas Abraham <thomas.ab@samsung.com>
Subject: Re: [PATCH 6/7] S3C6410: Add platform data for S3C IDE controller
	driver
Date: Mon, 2 Nov 2009 15:18:00 +0900
Message-ID: <84c135f50911012218o7142ff23y571517d8e96a6734@mail.gmail.com>
References: <1257051536-8170-1-git-send-email-thomas.ab@samsung.com>
	 <20091101130707.GJ8096@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:47189 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZKBGRz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Nov 2009 01:17:55 -0500
Received: by pxi9 with SMTP id 9so2985585pxi.4
        for <linux-ide@vger.kernel.org>; Sun, 01 Nov 2009 22:18:01 -0800 (PST)
In-Reply-To: <20091101130707.GJ8096@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 1, 2009 at 10:07 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:58:56PM +0900, Thomas Abraham wrote:
>> This patch adds platform data for S3C IDE controller driver in
>> S3C6410 platform.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>> =A0arch/arm/mach-s3c6410/mach-smdk6410.c | =A0 =A08 +++++++-
>> =A01 files changed, 7 insertions(+), 1 deletions(-)
>> -
>> +#ifdef CONFIG_BLK_DEV_IDE_S3C
>> + =A0 =A0 &s3c_device_cfcon,
>> +#endif
>> =A0 =A0 =A0 &smdk6410_smsc911x,
>> =A0};
>
> Firstly, doing stuff if the driver is enabled or not is not a good id=
ea,
> as it means re-installing the kernel if you then go and build the dri=
ver
> as a module at a later date.
>
> Two, since I guess that the IDE gpio setup should be the same across =
all
> s3c6410 based systems, then you should look at supplying a standard
> platform data that the board can use instead of having to duplicate t=
his
> across all the boards.
>

Ok. I will remove the conditional compilation and move the platform
data from SMDK board file. Since the IDE driver is not accepted, these
patches will be updated and resent again with the libata based driver.

Thanks Ben for reviewing the patches.

Thomas.
