From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
Date: Tue, 18 Jan 2011 20:10:19 -0500
Message-ID: <4D3639FB.10608@pobox.com>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com> <4D342C6E.6000608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41385 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab1ASBKX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 20:10:23 -0500
Received: by vws16 with SMTP id 16so134458vws.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 17:10:22 -0800 (PST)
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, kumar.gala@freescale.com, Roy Zang <tie-fei.zang@freescale.com>
Cc: Xulei <B33228@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org

On 01/17/2011 06:47 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 17-01-2011 10:10, Xulei wrote:
>
>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
>> information is at bit28 instead of bit22.
>
>> This patch adds FSL sata v2 probe and resolve this difference.
>
>> Signed-off-by: Xulei <B33228@freescale.com>
>
> AFAIK, full name is required.
>
>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> [...]
>
>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
>> b/arch/powerpc/boot/dts/p1022ds.dts
>> index 2bbecbb..9ad41dd 100644
>> --- a/arch/powerpc/boot/dts/p1022ds.dts
>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
>> @@ -475,14 +475,14 @@
>> };
>>
>> sata@18000 {
>> - compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>> + compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>> reg =<0x18000 0x1000>;
>> cell-index =<1>;
>> interrupts =<74 0x2>;
>> };
>>
>> sata@19000 {
>> - compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>> + compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
>> reg =<0x19000 0x1000>;
>> cell-index =<2>;
>> interrupts =<41 0x2>;
>
> Please put this into the separate patch and push thru the PPC tree.

I think it's OK to send 100% of this via the PPC tree.  The sata_fsl.c 
patch for data_snoop variability directly keys off a call to 
platform-specific detail (of_device_is_compatible call).

Acked-by: Jeff Garzik <jgarzik@redhat.com>

