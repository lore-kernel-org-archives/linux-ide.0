From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: Mounting CF flash card in 2.6.25
Date: Tue, 03 Jun 2008 21:34:17 +0400
Message-ID: <48458099.5020306@msgid.tls.msk.ru>
References: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>	 <20080603171923.7aaf87b5@core> <f608b67d0806030948t2df91060w46a9342a813ea216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:23746 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758079AbYFCReV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 13:34:21 -0400
In-Reply-To: <f608b67d0806030948t2df91060w46a9342a813ea216@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vb <vb@vsbe.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

vb wrote:
> Alan,
> 
> thank you for your reply, I am not quite clear with a couple of things
> though, please see below:
> 
> On Tue, Jun 3, 2008 at 9:19 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>> which tells me that the card is being recognized. However, there is no
>>> appropriate device get created in the /dev directory. Examining
>> The /dev creation is up to your initrd.
> 
> but I don't have initrd, so I need the kernel to create /dev/<drive>.
> It does create other devices, right?

Kernel does not maintain /dev, ever.  Times of devfs are long gone.
All nodes in your /dev are created in userspace.

>>> What needs to be done to get the device created and mapped to  a
>>> generic CF card?
>> You need to ensure you have SCSI_DISK support included (as CF is a disk)
>> and you need your initrd either to create device nodes, or to prepack
>> them.
> 
> I don't see SCSI_DISK as a config option, can you please elaborate on this?

It's CONFIG_BLK_DEV_SD.

/mjt
