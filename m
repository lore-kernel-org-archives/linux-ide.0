From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Drives missing at boot
Date: Wed, 7 Jul 2010 10:32:23 -0700
Message-ID: <AANLkTika_loMDw41Dvwgk5JbXm4Q8Hyoguto89khrOPz@mail.gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
	<4C2F5ECB.1040505@kernel.org>
	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>
	<4C2F61AB.9030806@kernel.org>
	<AANLkTilYOT45q8OUJ-_V61_fnYy9HIk6GAv5ZPiomCaT@mail.gmail.com>
	<4C317C04.20500@kernel.org>
	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>
	<4C32CE50.6010501@kernel.org>
	<AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
	<4C341598.6040004@kernel.org>
	<AANLkTik4zkcIyVxwtX8GA1BsQSZaAeODpPlY3mRVBc-4@mail.gmail.com>
	<4C34A1D5.1090202@kernel.org>
	<AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
	<4C34B8BE.5080504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55783 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0GGRcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jul 2010 13:32:25 -0400
In-Reply-To: <4C34B8BE.5080504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Jul 7, 2010 at 10:26 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 07/07/2010 07:06 PM, Mark Knecht wrote:
>> 4 warm reboots. All 4 said 300 300. However the 4th one only showed =
an
>> extra attempt at running the patch code with and also showed Tries =3D
>> 2. I'm attaching boot #1 and boot #4 for now. I've saved them all if
>> you need or just want them.
>>
>> Please note that in all 4 cases all drives were found. Nothing is
>> missing in any test yet after adding these either of these patches.
>>
>> I've not tried cold boots yet. That's next.
>
> Hmm... just in case you're being lucky, please keep an eye on it over
> several days and report the result. =C2=A0I think all that's necessar=
y is
> slight modification to the resume logic but let's watch a bit first.
>
> Thanks.
>
> --
> tejun
>
I've tried two cold boots so far. One of them had that same extra
Tries =3D 2 at the same place. I'll do a couple more just to see what
happens.

I'm happy to watch it as long as it takes and will certainly save any
results if and when a drive isn't found. This problem has run hot and
cold for a few months. Sometimes I go a week with every boot is good.
This last two weeks was finally bad enough to get me to report it.

I also want to investigate actually getting the BIOS AHCI setting
working, but I think I'll leave that alone for afew days so as to not
upset this experiment. Performance on the machine isn't critical right
now, assuming AHCI helps.

I'll get back to you when I've got something new to report.

Cheers,
Mark
