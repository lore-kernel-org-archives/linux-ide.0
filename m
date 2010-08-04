From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Drives missing at boot
Date: Wed, 4 Aug 2010 09:16:32 -0700
Message-ID: <AANLkTi=rt=krewXX3eLaGndqpQgdsTGF4+Z+43j92_9V@mail.gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>
	<4C317C04.20500@kernel.org>
	<AANLkTilupyieml9yaWO9BUNPmQQ0g2w1HLWj6R9MwDZf@mail.gmail.com>
	<4C32CE50.6010501@kernel.org>
	<AANLkTikehTO1j6Gd7Y_g32_P6Yg9KB8Z8qwbNJh10aOU@mail.gmail.com>
	<4C341598.6040004@kernel.org>
	<AANLkTik4zkcIyVxwtX8GA1BsQSZaAeODpPlY3mRVBc-4@mail.gmail.com>
	<4C34A1D5.1090202@kernel.org>
	<AANLkTilgQSu3qi7qoTtjnV22r-8Sh1hbDAB_nlPImWNt@mail.gmail.com>
	<4C34B8BE.5080504@kernel.org>
	<AANLkTilDbrA6lLPSOAtA8_4mLNkUZibHweTliqU5jd03@mail.gmail.com>
	<4C44BD42.3030904@kernel.org>
	<7141c88bc8c27f26c2187252c0594318.squirrel@thechecks.ca>
	<4C45AF40.7030800@kernel.org>
	<AANLkTinxDjPCk46eItZrXziTbf6efqvNNNTbkZDXIbns@mail.gmail.com>
	<4C483BF4.3090006@kernel.org>
	<AANLkTinwJLE=jjwG5zL8UBO91tzDpX36_W9GORKag8RK@mail.gmail.com>
	<20100803114105.7f199878.randy.dunlap@oracle.com>
	<AANLkTi=bKn3t8eD=n8tDeZrn-mXsEzFHGj46-Z5U9EGA@mail.gmail.com>
	<20100803115553.e4c51104.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100803115553.e4c51104.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, Paul Check <paul@thechecks.ca>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 3, 2010 at 11:55 AM, Randy Dunlap <randy.dunlap@oracle.com>=
 wrote:
> On Tue, 3 Aug 2010 11:47:25 -0700 Mark Knecht wrote:
>
>> On Tue, Aug 3, 2010 at 11:41 AM, Randy Dunlap <randy.dunlap@oracle.c=
om> wrote:
>> > On Mon, 2 Aug 2010 15:07:11 -0700 Mark Knecht wrote:
>> >
>> >> On Thu, Jul 22, 2010 at 5:39 AM, Tejun Heo <tj@kernel.org> wrote:
>> >>
>> >> Hi Tejun,
>> >> =C2=A0 =C2=A0I'm finally home and trying to get back to this. I'm=
 really a bad
>> >> programmer so I don't know what I've done wrong but it seems patc=
h
>> >> isn't happy with me.
>> >>
>> >> c2stable linux # patch --dry-run -p1 <../ata_piix-sidpr-lock.patc=
h
>> >> patching file drivers/ata/ata_piix.c
>> >> patch: **** malformed patch at line 13:
>> >
>> > Whenever the patch file was saved on this system, line 13 of it wa=
s
>> > split (probably by an email client). =C2=A0Whenever I see this, I =
just
>> > join (merge) that line and the next one and try again... sometimes
>> > several lines are malformed and have to be fixed like this.
>> >
>>
>> Randy,
>> =C2=A0 =C2=A0Could very well be what happened. I added line 13 (the =
printk) by hand
>>
>> <SNIP - ORIGINAL PATCH FILE>
>> struct piix_host_priv {
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 const int *map;
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 u32 saved_iocfg;
>> + =C2=A0 =C2=A0 =C2=A0 spinlock_t sidpr_lock; =C2=A0/* FIXME: remove=
 once locking in EH is fixed */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *sidpr;
>> };
>>
>> <SNIP - MY CHANGE BY HAND>
>> struct piix_host_priv {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const int *map;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 saved_iocfg;
>> + =C2=A0 =C2=A0 =C2=A0 spinlock_t sidpr_lock; =C2=A0/* FIXME: remove=
 once locking in EH is fixed */
>> + =C2=A0 =C2=A0 =C2=A0 printk("MWK - ata_sidpr patch applied!\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *sidpr;
>> };
>>
>> Maybe I should have just put it on the same line as the previous
>> spinlock command?
>>
>> I'll play with it and see if I can get it working.
>
>
> Ah, so you added a line to a patch file. =C2=A0That means that the pa=
tch
> block header must be changed from something like this:
>
> @@ -964,12 +968,15 @@
>
> to like this:
>
> @@ -964,12 +968,16 @@
>
> Any text following the second "@@" is just a comment so it does not m=
atter.
>
> The ,12 =C2=A0,15 =C2=A0 ,16 =C2=A0 are all line counts. The ",12" is=
 the number of lines
> in the before version of the patch. =C2=A0The ",15" or ",16" is the n=
umber of lines
> in the after version of the patch, so you would need to increase it b=
y 1 if
> you added one line. =C2=A0 Or you can just put the printk on the same=
 line as another
> part of the patch and it won't matter. =C2=A0:)
>
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode ***
>

Thanks Randy. This helped.

OK - so I'm going to hang fire on this problem right now. As part of
this process I've updated to a 2.6.35-gentoo kernel and I'm not seeing
the problem at all so far. I've booted about 25 times over the last 3
days - warm and cold boots mixed - and so far no failures. While I've
had times in the past where earlier kernels didn't exhibit the problem
for days I don't remember a time where I got this many good boots in a
row.

As my problem didn't seem to be exactly the same as Paul's, and since
Tejun expressed surprise that his fix for Paul's issue didn't fix
mine, maybe my problem is actually something different and (hopefully)
already fixed.

I'll continue to use the machine and watch for any failures. If I get
one I'll reengage the list and go into debug mode.

Cheers,
Mark
