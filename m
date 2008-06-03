From: vb <vb@vsbe.com>
Subject: Re: Mounting CF flash card in 2.6.25
Date: Tue, 3 Jun 2008 11:13:11 -0700
Message-ID: <f608b67d0806031113m45e2aa6eo874590eece48400e@mail.gmail.com>
References: <f608b67d0806021906g3020db3bve6515cbc8c7d99b5@mail.gmail.com>
	 <20080603171923.7aaf87b5@core>
	 <f608b67d0806030948t2df91060w46a9342a813ea216@mail.gmail.com>
	 <48458099.5020306@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:38258 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbYFCSNN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jun 2008 14:13:13 -0400
Received: by yw-out-2324.google.com with SMTP id 9so864170ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Jun 2008 11:13:12 -0700 (PDT)
In-Reply-To: <48458099.5020306@msgid.tls.msk.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Tue, Jun 3, 2008 at 10:34 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> vb wrote:
>> On Tue, Jun 3, 2008 at 9:19 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
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

Alan, Michael, this was it - now the /dev/sda and friends get created,
the CF gets mounted and the system comes up all the way to the login
prompt!

Thank you so much for your help, (and for my faith in free software
being restored :-))

What do you think: shouldn't enabling of PATA_OF_PLATFORM enable
BLK_DEV_SD automatically? This would have saved me (and maybe a few
more newbies who try doing this) a few days of banging my head against
the desk.

regards,
Vadim
