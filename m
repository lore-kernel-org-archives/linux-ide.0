From: Thomas Abraham <thomas.ab@samsung.com>
Subject: Re: [PATCH 5/7] S3C64XX: Add platform data and driver resources for
	IDE controller driver.
Date: Mon, 2 Nov 2009 15:13:27 +0900
Message-ID: <84c135f50911012213s8a137faua12e7f66c8d8ce76@mail.gmail.com>
References: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
	 <20091101130502.GI8096@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:36210 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZKBGNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Nov 2009 01:13:23 -0500
Received: by pxi9 with SMTP id 9so2983651pxi.4
        for <linux-ide@vger.kernel.org>; Sun, 01 Nov 2009 22:13:28 -0800 (PST)
In-Reply-To: <20091101130502.GI8096@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 1, 2009 at 10:05 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:56:43PM +0900, Thomas Abraham wrote:
>> This patch adds the following for S3C IDE driver.
>> =A0 =A0 =A0 - IDE plafrom data strucure definition
>> =A0 =A0 =A0 - IDE driver resources
>> =A0 =A0 =A0 - IDE controller GPIO setup code
>> =A0 =A0 =A0 - IDE platform data setup code
>> =A0 =A0 =A0 - IDE platform device definition
>>
>> +void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
>> +{
>> + =A0 =A0 struct s3c_ide_platdata *pd;
>> +
>> + =A0 =A0 pd =3D (struct s3c_ide_platdata *)kmemdup(pdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct s3c_ide_platdata), GFP_KERNE=
L);
>
> you do not need pd =3D (struct s3c_ide_platdata *), the result of kme=
mdup
> is 'void *' and thus can be cast to 'struct s3c_ide_platdata *'. Remo=
ving
> this will make the code flow better.
>
> doing:
>
> =A0 =A0 =A0 =A0if (!pd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: no memory for pla=
tform data\n", __func__);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s3c_device_cfcon.dev.platform_data =3D=
 pd;
>
> would be better.

Ok. I will modify the code.

>
> other than the comments, this looks ok.
>
> --
> Ben
