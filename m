From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] 2.6.34-rc3 Disable R_OK (Early ACK) on SII 3726/4726 PMP
Date: Wed, 14 Apr 2010 17:57:04 -0700
Message-ID: <i2qda824cf31004141757m8eb09beek86a41470bcdc9262@mail.gmail.com>
References: <m2gda824cf31004131746o15be77b1n7af6fac42ce25280@mail.gmail.com>
	 <4BC65E7C.5080203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:57828 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0DOA5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2010 20:57:09 -0400
In-Reply-To: <4BC65E7C.5080203@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, Apr 14, 2010 at 5:31 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 04/14/2010 09:46 AM, Grant Grundler wrote:
>> In 2009, While running "cache read" performance test of drives behin=
d
>> SII PMP we encountered a "all 5 drives" timeout on more than 30% of =
the
>> machines under test. =C2=A0This patch reduces the rate by a factor o=
f about 70.
>> Low enough that we didn't care to further investigate the issue.
>
> Interesting.
>
>> Performance impact with any sort of "normal" use was ~2%+ CPU and le=
ss
>> than 1% throughput degradation. =C2=A0Worst case impact (cached read=
) was
>> 6% IOPS reduction. This is with NCQ off (q=3D1) but I believe FIS ba=
sed
>> switching enabled in the SATA driver.
>
> Given the general flakiness of the device, I'm more than willing to
> pay some overhead for stability and the performance hit seems pretty
> small.
>
>> @@ -260,12 +262,28 @@ static int sata_pmp_configure(struct ata_devic=
e
>> *dev, int print_info)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 =C2=A0 /* For Sil3726, disable sending Early R_OK */
>> + =C2=A0 =C2=A0 =C2=A0 if (vendor =3D=3D 0x1095 && devid =3D=3D 0x37=
26) {
>
> Isn't this also applicable to 4723 and 4726?

Sorry, I don't know why I included 4726 in the Subject line since I
only tested with 3726.

I expect it would apply to 4726 but someone who knows the internals of
both would have to confirm that.

I don't know anything about 4723.


>
>> diff --git a/include/linux/ata.h b/include/linux/ata.h
>> index 700c5b9..18fc208 100644
>> --- a/include/linux/ata.h
>> +++ b/include/linux/ata.h
>> @@ -386,6 +386,7 @@ enum {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SATA_PMP_GSCR_ERROR_EN =C2=A0=3D 33,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SATA_PMP_GSCR_FEAT =C2=A0 =C2=A0 =C2=A0=3D=
 64,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SATA_PMP_GSCR_FEAT_EN =C2=A0 =3D 96,
>> + =C2=A0 =C2=A0 =C2=A0 SATA_PMP_GSCR_SII_POL =C2=A0 =3D 129, =C2=A0/=
* VENDOR : Silicon Image 3726/4726 */
>
> Can you plesae define it inside libata-pmp.c?

Yes. I'll resubmit with "SII_POL" defined "locally".

> ata.h only contains stuff defined by the ATA standard.

Ah ok. I didn't realize that.

>
> Other than the above nitpicks,
>
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks for the Ack/Review!
grant

>
> Thanks.
>
> --
> tejun
>
