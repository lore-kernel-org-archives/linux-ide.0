From: Simon Li <simon.jiyou@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Mon, 28 Jun 2010 17:09:10 +0800
Message-ID: <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com>
	<4C2777D3.1050208@gmail.com>
	<AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
	<4C28653E.4080908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48406 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0F1JJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jun 2010 05:09:11 -0400
Received: by pwj8 with SMTP id 8so3300963pwj.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Jun 2010 02:09:10 -0700 (PDT)
In-Reply-To: <4C28653E.4080908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

We don't expect kernel goes to temporary hung, any ideas for the fix?


On Mon, Jun 28, 2010 at 5:02 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 06/28/2010 03:38 AM, Simon Li wrote:
>>
>> May 25 15:55:06 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
>> DeviceFault CorrectedError Error }
>
>> May 25 15:59:59 shctc-xq-ems22-me18 kernel: ata3: status=3D0x25 {
>> DeviceFault CorrectedError Error }
>
>> Jun =A02 10:54:06 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
>> DeviceFault CorrectedError Error }
>
>> Jun =A02 10:54:08 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
>> DeviceFault CorrectedError Error }
>
>> Jun =A02 10:54:18 shctc-xm-ems21-me18 kernel: ata2: status=3D0x25 {
>> DeviceFault CorrectedError Error }
>
> Your hardware is returning errors, which libata is dutifully reportin=
g...
>
> =A0 =A0 =A0 =A0Jeff
>
>
>
