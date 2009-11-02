From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Subject: Re: [PATCH 5/7] S3C64XX: Add platform data and driver resources for
	IDE controller driver.
Date: Mon, 2 Nov 2009 22:13:40 +0100
Message-ID: <a01a16b50911021313h681bac38pdeea996a3e3cfb81@mail.gmail.com>
References: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
	 <20091101130502.GI8096@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:61750 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbZKBVNg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Nov 2009 16:13:36 -0500
Received: by ywh40 with SMTP id 40so4868175ywh.33
        for <linux-ide@vger.kernel.org>; Mon, 02 Nov 2009 13:13:41 -0800 (PST)
In-Reply-To: <20091101130502.GI8096@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2009/11/1 Ben Dooks <ben-linux@fluff.org>:
> On Sun, Nov 01, 2009 at 01:56:43PM +0900, Thomas Abraham wrote:
>> + =C2=A0 =C2=A0 if (!pd) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "%s: no =
memory for platform data\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 s3c_device_cfcon.dev.platform_data =3D pd;
>
> doing:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ER=
R "%s: no memory for platform data\n", __func__);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s3c_device_cfc=
on.dev.platform_data =3D pd;
>
> would be better.

I do not quite understand why this would be better. In the former case
the normal operation (e.g. s3c_dev... =3D pd;) is written directly with=
out
any extra indentation and is not buried (deep) down in some error handl=
ing.

Writing code in that style makes it very easy to read with a mental fil=
ter like

     if (test) {
             ERROR HANDLING, ERROR HANDLING, ERROR HANDLING, ERROR HAND=
LING;
             return;
     }
     NORMAL CASE, NORMAL CASE, NORMAL CASE, ;

See also http://stackoverflow.com/questions/114342/what-are-code-smells=
-what-is-the-best-way-to-correct-them/223881#223881.

BR H=C3=A5kon L=C3=B8vdal
