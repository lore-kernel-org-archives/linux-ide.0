From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: Support for 4 KiB disk sectors in Linux kernel
Date: Fri, 27 Apr 2012 07:53:46 -0700
Message-ID: <CAA9_cmdn-Efx3J5C7_Ow=JdnxnE-KqZu63HFCVBmfuJNdzQ2=Q@mail.gmail.com>
References: <4F9170FB.7080208@intel.com>
	<yq17gxa1iwc.fsf@sermon.lab.mkp.net>
	<4F919B55.2020802@fold.natur.cuni.cz>
	<D9FFE20C522965449E182ACE73889AEB1860718E@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59742 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760170Ab2D0Oxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Apr 2012 10:53:46 -0400
Received: by yhmm54 with SMTP id m54so426759yhm.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2012 07:53:46 -0700 (PDT)
In-Reply-To: <D9FFE20C522965449E182ACE73889AEB1860718E@IRSMSX101.ger.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dorau, Lukasz" <lukasz.dorau@intel.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, Apr 27, 2012 at 5:14 AM, Dorau, Lukasz <lukasz.dorau@intel.com>=
 wrote:
> On Friday, April 20, 2012 7:22 PM Martin Mokrejs wrote:
>>
>> Martin K. Petersen wrote:
>> >>>>>> "Lukasz" =3D=3D Lukasz Dorau <lukasz.dorau@intel.com> writes:
>> >
>> > Lukasz> Where can I find information about current status of suppo=
rt for
>> > Lukasz> 4 KiB disk sectors in Linux kernel? =A0Is there a
>> > Lukasz> leader/maintainer of this issue in community?
>> >
>> > We have supported 4Kn for a decade. 512e obviously works out of th=
e
>> > box. However, filesystem/partition/DM tooling has been updated to =
align
>> > correctly on 512e devices.
>> >
>
> Does it mean that I can just plug the 4K HDD in and it will work with=
out making any changes in kernel?
>

See sd_read_capacity() in drivers/scsi/sd.c
