From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: Re: [RFC] enable FUA support in libata
Date: Fri, 13 Apr 2012 23:25:25 +0800
Message-ID: <CANWLp01_fUhc72XUBcORGwh0s7r7g8CE5S7aqC+e2Sj4vf_DJA@mail.gmail.com>
References: <20120413081104.GA4953@gmail.com>
	<4F8835B8.2060400@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:54333 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2DMPZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2012 11:25:26 -0400
Received: by dake40 with SMTP id e40so4044829dak.11
        for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2012 08:25:25 -0700 (PDT)
In-Reply-To: <4F8835B8.2060400@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, Apr 13, 2012 at 10:18 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 04/13/2012 04:11 AM, Zheng Liu wrote:
>>
>> Hi Jeff and list,
>>
>> Recently I met a problem about FUA support of SATA disk. =A0In my ma=
chine,
>> it has a SATA disk that supports FUA feature. =A0But after system st=
arts
>> up, it displays that the disk cannot support FUA from dmesg.
>>
>> I notice this commit (c3c013a2). =A0It disables FUA support in all o=
f SATA
>> disk. =A0But the commit log is too simple to know why we should disa=
ble
>> FUA support in libata. =A0Could you please explain it? =A0Thank you.
>
>
> FUA support in the block layer wanted speed and guarantees that early=
 FUA
> drives were simply not providing.

Hi Jeff,

Thank you for your reply.  I notice that this patch is merged in 2006.
 I don't know whether we can enable it now by default or not.  I read
some specifications of SATA disks.  They support FUA feature.
Although libata_fua variable is a kernel module parameter and we can
enable it when this module is loaded,  it is too complicated because
it needs to be loaded before kernel is loaded.  Thus, we need to set
libata_fua in initrd.  Maybe we can change it into a sysctl parameter.
 Then we can enable it dynamically.  Do you have any suggestions?
Thank you.

Regards,
Zheng
