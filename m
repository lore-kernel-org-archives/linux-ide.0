From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Drive tester
Date: Thu, 23 Jul 2009 18:31:50 -0400
Message-ID: <87f94c370907231531r291ccadaude79a848a4a09286@mail.gmail.com>
References: <9b0a5b990907162309j2ff4f872v47b18be74c7eeab9@mail.gmail.com>
	 <23E65EE4544D484CBE73B588E192C6D612D3108FF0@sc-vexch3.marvell.com>
	 <87f94c370907231431p470874bax1155b88895cd97d5@mail.gmail.com>
	 <23E65EE4544D484CBE73B588E192C6D612D301CCCD@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:52811 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZGWWbv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 18:31:51 -0400
Received: by yxe14 with SMTP id 14so1006988yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2009 15:31:50 -0700 (PDT)
In-Reply-To: <23E65EE4544D484CBE73B588E192C6D612D301CCCD@sc-vexch3.marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Weiler <weilerb@marvell.com>
Cc: Kernelnewbies <kernelnewbies@nl.linux.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

cc'ing: linux-ide@vger.kernel.org

maybe they can help

On Thu, Jul 23, 2009 at 6:12 PM, Bill Weiler<weilerb@marvell.com> wrote=
:
>
>
> ________________________________________
> From: Greg Freemyer [greg.freemyer@gmail.com]
> Sent: Thursday, July 23, 2009 2:31 PM
> To: Bill Weiler
> Cc: Kernelnewbies
> Subject: Re: Drive tester
>
> On Wed, Jul 22, 2009 at 7:55 PM, Bill Weiler<weilerb@marvell.com> wro=
te:
>> I wanted to make an Application that could send scripted SCSI and SA=
TA
>> commands to my drives. I have found my Fedora Linux to be too comple=
x to
>> control the drives in this way. I have looked at minimal Linux but I=
 think
>> this would have the same problem. Is there an easier Open Source OS,=
 or an
>> embedded PC Linux that would be easier to modify?
>
> Bill,
>
> For sata drives, have you looked at the SG_IO interface?
>
> That is how hdparm interfaces with the kernel. =A0I know it sends a l=
ot
> of low level ATA commands to the drive from user space. =A0I think mo=
st
> use the SG_IO interface. =A0How much simpler can it get?
>
> strace hdparm may give you an education as to how simple it is.
>
> fyi: I believe the kernel looks for dangerous ata commands and blocks
> them. =A0But I think those are the types of commands that cause data
> loss. =A0Not sure what the criteria is.
>
> I have studied hdparm and the SG_IO interface and delved into the scs=
i drivers and ata drivers.
>
> For example, I wanted to script a single NCQ and a single NCQ write. =
A normal read(fd,buf,4096) does 1 NCQ read but a write(fd,buf,4096) doe=
s dozens of NCQ reads before doing the 1 NCQ write. How do I get rid of=
 these reads?
>
> Also, I need to do soft and hard resets and these are not exposed.
