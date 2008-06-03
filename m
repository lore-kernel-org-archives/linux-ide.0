From: vb <vb@vsbe.com>
Subject: Re: Mounting CF flash card in 2.6.25
Date: Tue, 3 Jun 2008 09:48:18 -0700
Message-ID: <f608b67d0806030948t2df91060w46a9342a813ea216@mail.gmail.com>
References: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
	 <20080603171923.7aaf87b5@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:18157 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYFCQsT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 12:48:19 -0400
Received: by wr-out-0506.google.com with SMTP id c48so3377644wra.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Jun 2008 09:48:19 -0700 (PDT)
In-Reply-To: <20080603171923.7aaf87b5@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan,

thank you for your reply, I am not quite clear with a couple of things
though, please see below:

On Tue, Jun 3, 2008 at 9:19 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>> which tells me that the card is being recognized. However, there is no
>> appropriate device get created in the /dev directory. Examining
>
> The /dev creation is up to your initrd.
>

but I don't have initrd, so I need the kernel to create /dev/<drive>.
It does create other devices, right?

>> What needs to be done to get the device created and mapped to  a
>> generic CF card?
>
> You need to ensure you have SCSI_DISK support included (as CF is a disk)
> and you need your initrd either to create device nodes, or to prepack
> them.
>

I don't see SCSI_DISK as a config option, can you please elaborate on this?

TIA,
/vb
