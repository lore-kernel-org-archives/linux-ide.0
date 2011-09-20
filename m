From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: ATA TRIM on non-AHCI motherboards ?
Date: Tue, 20 Sep 2011 17:34:47 -0400
Message-ID: <CAGpXXZK0KKA6Z=Ro5Xf1uTa2-cGQ0UGj9MnvUxM-V_fN5yVT8A@mail.gmail.com>
References: <CAACN17gFBF=-UjWzAm_g3QNemyN6to3NaQqBJepWKH=DQkx7-Q@mail.gmail.com>
 <CAACN17jsVRZ=nXWzvDMSHLmaR1s5a38j_1YWvhq8FFA63_nU6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63808 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1ITVfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2011 17:35:17 -0400
Received: by iaqq3 with SMTP id q3so975170iaq.19
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2011 14:35:17 -0700 (PDT)
In-Reply-To: <CAACN17jsVRZ=nXWzvDMSHLmaR1s5a38j_1YWvhq8FFA63_nU6w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thibaut bethune <thibaut.bethune@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, Sep 19, 2011 at 7:35 PM, thibaut bethune
<thibaut.bethune@gmail.com> wrote:
> Hello again
>
> I've formatted my SSD using ext4 and enabled TRIM using the "discard"=
 option.
> Then i've run that test
> https://sites.google.com/site/lightrush/random-1/checkiftrimonext4ise=
nabledandworking
> and it failed : no TRIM with that configuration.
>
> Since it's theorically possible to get TRIM without AHCI, only using
> 48-bit LBA addressing, do you know if a can find a driver that would
> enable TRIM ?
>
> thanks in advance
>
> Thibaut
> France
>
> 2011/9/14 thibaut bethune <thibaut.bethune@gmail.com>:
>> Hello,
>>
>> I'd like to know if my system is ATA TRIM compatible :
>>
>> 1=B0) I've just bought a SATA SSD (Crucial M4) which handles TRIM
>> 2=B0) I'm running Linux 2.6.33 whch also handles TRIM (ext4 + "disca=
rd" option)
>> 3=B0) My motherboard (ASRock Conroe 1333 DVI/H R2.02, featuring the =
ICH7
>> southbridge) doesn't handle AHCI. Yet 48-bit LBA addressing is
>> supported.
>>
>> I did some research and I've read that 48-bit LBA addressing should =
be
>> enough to get TRIM IF the driver is compatible.
>>
>> Is it the case ?
>>
>> Thanks in advance
>>
>> Thibaut
>> 35'
>> France

I don't have any answers for you, but I do want to argue with the
apparent assumption that mount -t ext4 -o discard is a good thing.

To date I have not read of any devices that truly benefit from that.

On the other hand, recent versions of e2fsprogs have a userspace tool,
fstrim.  It works by invoking a kernel ioctl that has been around for
about a year.  Maybe more.

You can setup cron to invoke fstrim daily (or whatever).  It has the
advantage of keeping your ssd fairly well "trimmed-up" but not the
negative aspect of interspersing trim commands in the middle of your
normal data packets.  (Typically this seems to cause a cache flush on
the ssd, so it really drops performance.)

=46YI:
I wrote most of: http://en.opensuse.org/SDB:SSD_discard_%28trim%29_supp=
ort

If you find anything relevant out related to drivers that do or don't
support trim, it be great if you would update the wiki article.  Or
post it here and I will try to do so.

Greg
