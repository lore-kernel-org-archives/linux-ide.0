From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: libata: init ata_print_id to 0
Date: Mon, 23 Apr 2012 09:34:07 -0700
Message-ID: <CABE8wwtOiy7vXL8tLbt2mR0C4xyfNm2CJNOUg3By3p59Jg=gDw@mail.gmail.com>
References: <alpine.LFD.2.02.1204221136450.1947@terrop>
	<4F957629.1050102@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:40847 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753468Ab2DWQeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2012 12:34:12 -0400
Received: by bkcji2 with SMTP id ji2so1054161bkc.25
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2012 09:34:07 -0700 (PDT)
In-Reply-To: <4F957629.1050102@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tero Roponen <tero.roponen@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>

On Mon, Apr 23, 2012 at 8:32 AM, Mark Lord <kernel@teksavvy.com> wrote:
> On 12-04-22 04:38 AM, Tero Roponen wrote:
> ..
>> The change of numbering comes from commit 85d6725b7c0d7e3f ("libata:
>> make ata_print_id atomic") that changed lines like
>>
>> =A0 =A0 =A0 ap->print_id =3D ata_print_id++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 to
>> =A0 =A0 =A0 ap->print_id =3D atomic_inc_return(&ata_print_id);
>>
>> As the latter behaves like ++ata_print_id, we must initialize
>> it to zero to start the numbering from one.
>
> Darn! =A0And here I though we'd finally end up with libata numbering
> matching the scsi host numbering (on most systems). =A0:)
>

That would be nice.  Libsas allocates a new ata_port and id on every
hotplug event.  Whereas libata at least alllocates a port id at load
time and persists that until the driver unloads.

It makes the per-port libata.force=3D options impossible to use...

Although, it couldn't be scsi host number based, because we only get
one host number for an entire sas domain.

--
Dan
