From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: NV Cache Feature Support in libata
Date: Wed, 1 Aug 2007 10:57:55 -0600
Message-ID: <8202f4270708010957y6e5a11deye26d427ee243b05d@mail.gmail.com>
References: <8202f4270702091025k77c3171fr6bb3b5b6088df85b@mail.gmail.com>
	 <BCFC7DEC-CE1E-4F88-961E-F86F7C69528D@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:27416 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbXHAQ55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 12:57:57 -0400
Received: by el-out-1112.google.com with SMTP id j27so54757elf
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 09:57:55 -0700 (PDT)
In-Reply-To: <BCFC7DEC-CE1E-4F88-961E-F86F7C69528D@sbcglobal.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Bisson <timbisson@sbcglobal.net>
Cc: linux-ide@vger.kernel.org

Did you refer to "HDIO_DRIVE_CMD ioctl" in old IDE code? I couldn't
get it working on libata.  Based on libata-scsi code, only PIO data in
and Non-data protocol are supported for HDIO_DRIVE_CMD while NV Cache
commands requires DMA based on ATA8 spec.

I tried to use ATA pass through command for NV Cache commands. For
instance,  I implemented Add LBA to Pinned Set command just like Write
DMA Extended with the differences in command, feature and LBA register
bit 0, but I got "protocol mismatch" error from device.

I would appreciate any information in regard to libata support on NV
Cache commands.

Thanks,
Fajun


On 2/9/07, Timothy Bisson <timbisson@sbcglobal.net> wrote:
>
>
> On Feb 9, 2007, at 10:25 AM, Fajun Chen wrote:
>
>
> I'm not aware of any NV cache (vista feature documented in
>
> ata-atapi-8) support in libata. Is this supported or any plan to
>
> support it in the future?
> It is already supported through the HDIO_DRIVE_CMD ioctl - pass 0xb6 as the
> command register value.
>
> I think the interesting question is, how can we leverage the NV Cache in the
> block and file system layers to improve power and performance. One probably
> obvious option is to enter NV Cache Power Mode when laptop mode is enabled.
>
> Tim
