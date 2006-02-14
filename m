From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Tue, 14 Feb 2006 08:57:04 -0600
Message-ID: <A9DB3731-BF2F-4C52-BFBB-7E247E646FA6@kernel.crashing.org>
References: <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com> <Pine.LNX.4.44.0602131020370.30316-100000@gate.crashing.org> <58cb370e0602130853s4ce767c6j57337a9587cc2963@mail.gmail.com> <9E02DAB4-8DCE-42AA-8F47-080636F78E4C@kernel.crashing.org> <58cb370e0602131221k60e23cffo480fbec812b6560e@mail.gmail.com> <4EAA9C9B-947B-493D-B3D9-CFA1EC0A71CA@kernel.crashing.org> <58cb370e0602131435u317d1f2fxec9f156328807e9e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:9369 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1161059AbWBNO4r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Feb 2006 09:56:47 -0500
In-Reply-To: <58cb370e0602131435u317d1f2fxec9f156328807e9e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>> Now I'm confused.  If I understand the code, what I want is for the
>> "io_32bit" setting to have its RW field set to SETTING_READ, such
>> that drive->no_io_32bit can NOT be changed.  Additionally, I want it
>> set to 1 if hwif->no_io_32bit is 1.
>
> Yes.
>
>> Are you saying that at the end of probe_hwif() I should iterate over
>> the drives for that hwif and set drive->no_io_32bit to 1 if hwif-
>>> no_io_32bit is 1?  If so, can I do this in the last loop that
>> already exists that iterates over the drives?
>
> Well, no - this loop is for tuning and is already over-complicated.
>
>> Will I not also want to test hwif->no_io_32bit in idedisk_setup() to
>> ensure that it can only set driver->no_io_32bit to 0 if hwif-
>>> no_io32bit is 0?
>
> No, you want to move this code to ide-probe.c because of the
> reason given in my last mail: setting drive->no_io_32bit in ide-disk
> is too late w.r.t. ide_add_generic_settings():
>
> init_gendisk()->hwif_init()->ide_add_generic_settings()
>
> so drive->no_io_32bit flag needs to be set earlier
> (probe_hwif() is OK).

Will drive->id->dword_io be valid by the end of probe_hwif()?

> And yes, this IDE stuff is complicated... :)

That it is ;)

- kumar
