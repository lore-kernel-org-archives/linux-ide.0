From: Jeff Garzik <jeff@garzik.org>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
Date: Wed, 06 Apr 2011 14:12:47 -0400
Message-ID: <4D9CAD1F.6060500@garzik.org>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com> <C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34592 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab1DFSMw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2011 14:12:52 -0400
Received: by qyk7 with SMTP id 7so2713025qyk.19
        for <linux-ide@vger.kernel.org>; Wed, 06 Apr 2011 11:12:51 -0700 (PDT)
In-Reply-To: <C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Cc: Leon Woestenberg <leon.woestenberg@gmail.com>, Linux PPC <linuxppc-dev@ozlabs.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 04/06/2011 01:48 PM, Moffett, Kyle D wrote:
> On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
>> after investigating problems with sata_sil24.c on a freescale p2020
>> soc, I wonder if this driver works on powerpc at all?
>>
>> Does anyone know of a working setup of sata_sil24 on a big endian
>> powerpc system?
>
> Our P2020 boards work fine with legacy PCI interrupts (I think it's a sil3124 over PCI-E); the only deficiency is that MSI does not seem to work.
>
> I know our MSI *does* work in general because we have an Intel 82571EB chipset also attached via PCI-E with working MSI.

We've definitely had issues with sata_sil24 + MSI, also...

sata_sil24 does work on big endian in general.

	Jeff



