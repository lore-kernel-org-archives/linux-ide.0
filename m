From: Gwendal Grignou <gwendal@google.com>
Subject: Re: qc timeout ... failed to IDENTIFY - qemu/kvm setup
Date: Sat, 28 Aug 2010 17:35:38 -0700
Message-ID: <AANLkTikg3KPatbFJk10_=tZ6xjq_OiCfTwFz-63eqyvT@mail.gmail.com>
References: <AANLkTikAAAGg-OO81my14YAkQP-wK86rmXVhAiqAWf1i@mail.gmail.com>
	<4C6AB586.6090807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:16012 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab0H2Afp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Aug 2010 20:35:45 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id o7T0ZhjU031040
	for <linux-ide@vger.kernel.org>; Sat, 28 Aug 2010 17:35:43 -0700
Received: from ywt2 (ywt2.prod.google.com [10.192.20.2])
	by kpbe11.cbf.corp.google.com with ESMTP id o7T0ZfOL012117
	for <linux-ide@vger.kernel.org>; Sat, 28 Aug 2010 17:35:41 -0700
Received: by ywt2 with SMTP id 2so2085591ywt.27
        for <linux-ide@vger.kernel.org>; Sat, 28 Aug 2010 17:35:40 -0700 (PDT)
In-Reply-To: <4C6AB586.6090807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tharindu Rukshan Bamunuarachchi <btharindu@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Check the patch I just submitted "libata-sff: Reenable Port Multiplier
after libata-sff remodeling.". It fixes a problem with port
multiplier. I had the same error signature as yours.

Gwendal.

On Tue, Aug 17, 2010 at 9:15 AM, Tejun Heo <tj@kernel.org> wrote:
> On 08/09/2010 07:55 PM, Tharindu Rukshan Bamunuarachchi wrote:
>> hi All,
>>
>> I am getting following message when I try to start my qemu/kvm virtu=
al machine.
>> I have been using qemu/kvm setup for last couple of months, issue wa=
s
>> introduced after upgrading to v2.6.35-rc6.
>>
>> VM starts as usual when I disable SMP. Issue is not visible in v2.6.=
34x.
>>
>> [ =A0 =A06.052229] ata1.01: qc timeout (cmd 0xec)
>> [ =A0 =A06.054105] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>> [ =A0 =A06.056653] ata2.01: qc timeout (cmd 0xec)
>> [ =A0 =A06.058453] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>> [ =A0 16.212186] ata1.01: qc timeout (cmd 0xec)
>> [ =A0 16.214056] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>> [ =A0 16.220146] ata2.01: qc timeout (cmd 0xec)
>> [ =A0 16.221986] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>> [ =A0 46.376202] ata1.01: qc timeout (cmd 0xec)
>> [ =A0 46.378164] ata1.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>> [ =A0 46.384165] ata2.01: qc timeout (cmd 0xec)
>> [ =A0 46.386140] ata2.01: failed to IDENTIFY (I/O error, err_mask=3D=
0x4)
>>
>> I think following CONFIGs are introduced with latest version ... cou=
ld
>> there be any relation to above error ..
>>
>> CONFIG_IO_DELAY_TYPE_0X80=3D0
>> CONFIG_IO_DELAY_TYPE_0XED=3D1
>> CONFIG_IO_DELAY_TYPE_UDELAY=3D2
>> CONFIG_IO_DELAY_TYPE_NONE=3D3
>> CONFIG_IO_DELAY_0X80=3Dy
>>
>>
>> Please provide any clue or debug method to resolve the issue ?
>> Could this be an issue with kvm/qemu ?
>>
>> Sorry if i am addressing wrong mailing-list.
>
> If the problem is qemu specific, it would probably be bettr to report
> it to qemu mailing list. =A0Can you please post full kernel log just =
in
> case?
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
