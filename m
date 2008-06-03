From: vb <vb@vsbe.com>
Subject: Re: Mounting CF flash card in 2.6.25
Date: Tue, 3 Jun 2008 10:49:27 -0700
Message-ID: <f608b67d0806031049g24779a09o56bfac0bd6f6384c@mail.gmail.com>
References: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
	 <20080603171923.7aaf87b5@core>
	 <f608b67d0806030948t2df91060w46a9342a813ea216@mail.gmail.com>
	 <48458099.5020306@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:15200 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbYFCRt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 13:49:29 -0400
Received: by yx-out-2324.google.com with SMTP id 31so180081yxl.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Jun 2008 10:49:28 -0700 (PDT)
In-Reply-To: <48458099.5020306@msgid.tls.msk.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-ide@vger.kernel.org

Michael, thank you for your reply and pardon my ignorance,

On Tue, Jun 3, 2008 at 10:34 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Kernel does not maintain /dev, ever.  Times of devfs are long gone.
> All nodes in your /dev are created in userspace.
>

but I see that the kernel creates /dev/ram[0..15],
/dev/mtdblock[0..3], at least I see these mentioned in
block/genhd.c:major_names[] - are these not devices created by kernel?

Are you saying that I can't mount a CF card without initrd (or nfs
mounted userland, etc.)?

>>>> What needs to be done to get the device created and mapped to  a
>>>> generic CF card?
>>>
>>> You need to ensure you have SCSI_DISK support included (as CF is a disk)
>>> and you need your initrd either to create device nodes, or to prepack
>>> them.
>>
>> I don't see SCSI_DISK as a config option, can you please elaborate on
>> this?
>
> It's CONFIG_BLK_DEV_SD.
>

thank you for the hint, let me try this...

cheers,
/vb

> /mjt
>
