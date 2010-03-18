From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 18 Mar 2010 11:36:50 -0700
Message-ID: <150c16851003181136n5f0ddc2cgbc303a300c5dbe1d@mail.gmail.com>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc>
	 <4B9D0772.4080306@teksavvy.com> <4B9D7924.1020908@kernel.org>
	 <201003181716.00173.suse-linux@ml082.pinguin.uni.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f198.google.com ([209.85.216.198]:56116 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0CRSgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 14:36:52 -0400
Received: by pxi36 with SMTP id 36so1707710pxi.21
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 11:36:51 -0700 (PDT)
In-Reply-To: <201003181716.00173.suse-linux@ml082.pinguin.uni.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Bogner <suse-linux@ml082.pinguin.uni.cc>
Cc: Tejun Heo <tj@kernel.org>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

On Thu, Mar 18, 2010 at 9:15 AM, Al Bogner
<suse-linux@ml082.pinguin.uni.cc> wrote:
> Am Montag 15 M=E4rz 2010 01:02:44 schrieb Tejun Heo:
>> Hello,
>>
>> On 03/15/2010 12:57 AM, Mark Lord wrote:
>> > No. =A0The vendor-unique commands appear to download a small firmw=
are
>> > packet to the drive, which reprograms it for a longer "IDLE-3" tim=
eout.
>> >
>> > "IDLE-3" is what WD call this vendor-specific "powersaving" mode,
>> > and it is not intended to be adjustable. =A0Except via that little
>> > DOS utility hack, and even WD no longer make that available.
>> >
>> > But I found it by googling for it, and it can change the timeout
>> > up to 30 seconds from the default of 8. =A0So I set my WD 1.5TB dr=
ive
>> > to use 30, and things are now acceptable.
>> >
>> > Ugh (again)!
>>
>> I'm currently talking with WD but in general I'm leaning toward simp=
ly
>> leaving it alone. =A0The manufacturer is actively preventing those
>> timesouts from being adjusted and they probably have a pretty good
>> rationale for that. =A0If those drives expire before their warrnty, =
it's
>> a matter between the customer and the vendor. =A0I really don't see =
much
>> point in trying to circumvent it. =A0Anyways, I'll let you guys know
>> where the conversation w/ WDC leads to.
>
> WD said to me I can send them the disk, but didn't accept, that this =
is a
> firmware bug.
>
> Today I got a brandnew WD20EARS (2TB) and it is the same. After about=
 an 1/2
> hr. I had 12 cycles with an _un_formatted disk.
>
> I cannot accept, that it should be a warranty issue, because this red=
uces the
> lifetime _after_ the warranty and increases the possibility to loose =
data, at
> least for those who don't use a raid.
>
> I would be happy to have a native linux utility to change this.
>

I'm not sure if that model supports the advanced power management
command or not, but hdparm -B254 should fix it.  Sadly, many WD models
affected by this don't implement the APM command.

-Justin
