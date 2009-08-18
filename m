From: Chris K <kayex@rogers.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Tue, 18 Aug 2009 17:54:48 -0400
Message-ID: <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>
	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>
	 <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:36597 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZHRVys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Aug 2009 17:54:48 -0400
Received: by bwz22 with SMTP id 22so3313567bwz.18
        for <linux-ide@vger.kernel.org>; Tue, 18 Aug 2009 14:54:48 -0700 (PDT)
In-Reply-To: <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Mon, Aug 17, 2009 at 10:39 PM, Grant Grundler<grundler@google.com> w=
rote:
> On Mon, Aug 17, 2009 at 3:30 PM, Chris K<kayex@rogers.com> wrote:
>>...
>>>>> > I have a Silicone Image 3132 chipset (PCI-E 2-port eSATA contro=
ller
>>>>> > card) and a Sans Digital TRM4-B 4x hard drive enclosure
>>>
>>> Which PMP is in the TRM4-B HDD enclosure?
>>
>> After opening it up, it looks to be a Silicone Image 3726 chip.
>
> Ok ...just some questions to pull a bit more info. Still no idea what=
 is wrong.
>
> Can you confirm the OS is seeing as a 3726?
> Add a printk to dump SATA_PMP_GSCR_PROD_ID to the console
> similar to how it's done in sata_pmp_revalidate_quick(). =A0Or if dev=
->gscr[]
> is already valid, printk dev->gscr[SATA_PMP_GSCR_PROD_ID]. This
> assumesyou know how to build/install a kernel from a source tree.
> Tell me if that's a bad assumption. :)

How about generous assumption ;-)  Could you elaborate on the steps
for this? I should be able to figure it out with a bit more info on
the process.

>
> ISTR some very early 3726 devices reported themselves as 4726 or
> something like that.
> This can affect which sata_pmp_quirks() are applied.

I noticed this line in the dmesg, does this confirm if it's reporting
the right model properly?
"ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9=
"

>
> BTW, the full dmesg output attached to the original mail never made i=
t
> to linux-ide mailing list...can you attach or post it someplace publi=
c?

Yes, you can find my dmesg @ http://pastebin.com/f50585886

Not sure if you saw this part before too - This is the output I get on
the screen during boot:

[59719.989422] ata7: irq_stat 0x01100010, PHY RDY changed
[59719.989477] ata7: SError: { 10B8B }
[59722.781043] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe =
frozen
[59722.781112] ata7: irq_stat 0x00b40090, PHY RDY changed
[59791.300259] ata7.15: failed to write PMP_FEAT_EN (Emask=3D0x40)
[59791.300324] ata7: failed to recover PMP after 5 tries, giving up
[59791.300323] ata7: exception Emask 0x3 SAct 0x0 SErr 0x0 action 0x6 f=
rozen t4
[59791.300483] ata7: irq_stat 0x00060002, device error via D2H FIS

>
>> There's a sticker on the circuit board with "BIOS 1.0114"
>
> Should be good. 1.0114 firmware has one problem I can't talk about no=
w
> (NDAs, etc) and is unlikely to be related to this problem.
>
>
>
> ..
>>> My guess is the LEDs going on and off are caused by the PMP getting=
 reset
>>> and not the Host OS "scanning". Are all the LEDs going on or off at
>>> the same time?
>>> Can you describe the on/off sequence of the LEDs?
>>>
>>
>> Sure. The Power and "HOST" LEDs both light up, followed by LED "1"
>> which is orange very briefly, green, orange briefly, green stays lit=
,
>
> How long between LED 1 and LED 2?
> Is the sequence different if you power off the TRM4-B and power it
> on again before rebooting the host machine?
>

LED 1 takes about 2-3 seconds.. the other LEDs are lit very quickly
one after another.

> If CONFIG_PRINTK_TIME=3Dy, the dmesg output should let me figure this=
 out.
>

This seems to be enabled already with my current kernel.

> I'm expecting some sort of "spin up delay" to take effect but offhand
> don't know the code path or if it will matter for this problem.
>
>> LED "2" orange very briefly, green stays lit, LED "3" orange very
>> briefly, green stays lit, LED "4" orange very briefly, green stays l=
it
>> - at this point all LEDs are on.
>
> Ok - this does sound like ports behind the PMPs are being scanned.
>
>> Shortly after all LEDs turn off
>> together and the process repeats itself about 5 times.
>
> Can you add debug code to dump how many ports the PMP claims to have?
> I'm wondering if a "ghost port" (magic "port" which doesn't have a SA=
TA link but
> some magic registers instead) is discovered/reported.
>

I can sure try! What should I do to enable this?

Thanks,

Chris.

>> After it
>> finishes it keeps Power, HOST and "1" lit up and then I receive the
>> error messages.
>
> I suspect the PMP probe code sets up the link before exiting the erro=
r
> handling loop. This would leave the link 1 (port 0 on PMP) on.
>
> thanks,
> grant
>
>>
>>> I'm hoping the would tell us more about where in the discovery proc=
ess
>>> it's failing.
>>> I don't even have a good guess what the problem might be.
>>>
>>> hth,
>>> grant
>>>
>>
>> Haha, I know the feeling. Ran out of ideas a long time ago :-). =A0L=
et
>> me know if there's anything else you'd like me to try or any further
>> info you require.
>>
>> Thanks.
>>
>> Chris.
>>
>
