From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port
 Multiplier Sil3726
Date: Fri, 23 Mar 2012 13:14:33 +0800
Message-ID: <CAMHSBOWDYyLRREZNGqhBtvF_gSrvB-b=PVx3qULCqpc7yeJCcQ@mail.gmail.com>
References: <4F5ECD06.3000608@yahoo.co.jp>
	<4F5F7C4C.7080800@teksavvy.com>
	<4F662AFB.9050106@yahoo.co.jp>
	<CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com>
	<4F6AAC37.7040907@yahoo.co.jp>
	<4F6B30D9.2070805@yahoo.co.jp>
	<CAMHSBOVD4wAtwAravVkDjyWV+Nwtuybt=yae=26PcGxxirw=Lg@mail.gmail.com>
	<4F6B679C.60004@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63828 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab2CWFOe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2012 01:14:34 -0400
Received: by qcqw6 with SMTP id w6so1794425qcq.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2012 22:14:33 -0700 (PDT)
In-Reply-To: <4F6B679C.60004@yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Mar 23, 2012 at 1:55 AM, ANEZAKI, Akira
<fireblade1230@yahoo.co.jp> wrote:
> Hello Gwendal,
>
> Thank you for your information.
> I think ata8 might different from other 3 PMPs. I'll try to update al=
l
> firmware but it is running resync on broken RAID now. So I can't do i=
t soon.
> By the way, both of ata8 and ata9 loses some HDDs also. Are those
> affected by PMPs on ata7 and ata10? Why 3.1.x driver can work?
>
> Best Regards,
> Akira
>
>> Now I see your problem. Indeed on ata7, ata10, we have a problem.
I should have said ata7-ata10. The PMP on these 4 enclosures do not
like SRST at all.
It works with 3.1.x because it does not send SRST with this PMP; but
as I said before, that is not a good behavior [no staggered spin-up,
problem with drives slow to spin-up]

Gwendal.
>> I notice however some messages I did not see before:
>>>> [ =A0 =A04.856382] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23=
, 6 ports, feat 0x1/0x9
>>>> [ =A0 =A04.858742] ata7.00: hard resetting link
>>>> [ =A0 14.843039] ata7.00: softreset failed (timeout)
>>>> [ =A0 17.836402] ata7.15: qc timeout (cmd 0xe4)
>> The later indicates that the PMP is stuck and the host can not read
>> its internal register.
>> Is it possible that the PMP in these 4 enclosures you are using have=
 a
>> different firmware than the other ones?
>> Firmware 1.0114 is available at:
>> http://www.siliconimage.com/support/searchresults.aspx?pid=3D26&cat=3D=
23
>>
>> From the release notes:
>> """- Fix SRST and initial two RegFIS Problem."""
>>
>> Gwendal.
>
