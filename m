From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Sat, 8 Jan 2011 09:30:31 -0600
Message-ID: <AANLkTinwwocdQkT6NeeVOhxWF4Ty5uFYiUZhHiv7XX-V@mail.gmail.com>
References: <845423.62876.qm@web112007.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39395 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1AHPac convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 10:30:32 -0500
Received: by iwn9 with SMTP id 9so18027857iwn.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 07:30:32 -0800 (PST)
In-Reply-To: <845423.62876.qm@web112007.mail.gq1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Denchfield <td_denchfield@yahoo.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, Jan 7, 2011 at 10:51 AM, Tom Denchfield <td_denchfield@yahoo.co=
m> wrote:
> Robert, yes, the IDE socket missing pin was # 20, the Key needed for =
80-conductor IDE cables, as you stated below.=A0 I had to take the adap=
ter out so I carefully looked at it and compared it to a photograph on =
a pin-out Internet site.
>
> I also looked at an enlarged photo of the laptop CF card adapter pict=
ured in URL03, and counted 44 pins - at least counting from the bottom =
of the socket.
>
> I notice that the dmesg output in my Wednesday, January 5, 2011 11:33=
 PM email to you guys has been removed from you response below. =A0I re=
alize that you need to keep emails shorter than those that I write, but=
 I think that the dmesg demonstrates that my particular CF card adapter=
 is indeed capable of being forced (libata.force=3D80c) to UDMA/66 even=
 though it is not (economically) feasible to insert a 80-wire IDE cable=
 between the CF card adapter and the IDE socket on a desktop computer's=
 motherboard.

Yes, in this case there's likely no issue with using speeds faster
than UDMA33. However, problem is that since these kind of adapters are
essentially passive devices, there's no way for the kernel to detect
them automatically. In this sort of case, the libata.force option is
likely the best one.

>
> Robert, again thank you for helping me, and I hope that I may have co=
ntributed at least a little bit of useful information.
>
> Tom
>
>
> --- On Thu, 1/6/11, Robert Hancock <hancockrwd@gmail.com> wrote:
>
>> From: Robert Hancock <hancockrwd@gmail.com>
>> Subject: Re: CF Card Adapter White List Candidate
>> To: "Tom Denchfield" <td_denchfield@yahoo.com>
>> Cc: "Tejun Heo" <htejun@gmail.com>, linux-ide@vger.kernel.org
>> Date: Thursday, January 6, 2011, 10:22 PM
>> On Wed, Jan 5, 2011 at 11:33 PM, Tom
>> Denchfield <td_denchfield@yahoo.com>
>> wrote:
>> > The reason that I mentioned powering my CF adapter
>> with a floppy drive power plug is that the first time I
>> booted after inserting the adapter, I forgot to plug the
>> floppy drive power plug into the adapter.=A0 The adapter's
>> power on LED did not light, and I think that Ubuntu did not
>> see the CF card.
>> >
>> > The reason that I mentioned the pin that was
>> intentionally left out of the motherboard IDE socket was
>> that I thought that the missing pin might have had something
>> to do with needing to power the adapter with the floppy
>> drive power plug given my experience with forgetting to plug
>> the floppy power plug into the adapter as mentioned in the
>> previous paragraph.
>> >
>> > The pin that is missing from the motherboard IDE
>> socket is very close to the middle of the IDE socket.=A0 My
>> guess is that the pin is in the in the range #18 to #24.
>> It is far away from pin #34.=A0 I am going by memory here,
>> but I clearly remember that the missing pin is in the
>> middle.=A0 Pin #34 is going into the CF card adapter when I
>> insert it.=A0 I do not know whether pin #34 is grounded at
>> the mainboard.
>>
>> If it's pin 20, that's a key pin that's always missing and
>> which has
>> the corresponding hole filled in on the cable side (from
>> compliant
>> connectors, anyway), to prevent plugging in the cable the
>> wrong way
>> around.
>>
>> Not sure where the adapter would be potentially drawing
>> power from on
>> the IDE connector - as far as I know there aren't any pins
>> on a
>> standard IDE connector which provide continuous power. The
>> adapters
>> I've seen all use an extra power connector.
>>
>> >
>> > When I asked my question, before I noticed and paid
>> any real attention to the UDMA/100 CF card configured as
>> UDMA/100 in URL03 above, I was concerned that there might be
>> a UDMA/66 speed limit with the type of CF card adapter that
>> I have. =A0We may never know for sure until someone who has a
>> CF card that is faster than UDMA/66 tries it in the URL01
>> adapter with Linux and the libata.force=3D80c boot parameter.
>> >
>> > Robert, thank you for helping me. =A0I hope that my
>> additional comments and the information above will
>> contribute to further Linux kernel development.
>> >
>> > Tom
>> >
>> > --- On Wed, 1/5/11, Robert Hancock <hancockrwd@gmail.com>
>> wrote:
>> >
>> >> From: Robert Hancock <hancockrwd@gmail.com>
>> >> Subject: Re: CF Card Adapter White List Candidate
>> >> To: "Tom Denchfield" <td_denchfield@yahoo.com>
>> >> Cc: "Tejun Heo" <htejun@gmail.com>,
>> linux-ide@vger.kernel.org
>> >> Date: Wednesday, January 5, 2011, 5:47 PM
>> >> On Wed, Jan 5, 2011 at 12:18 PM, Tom
>> >> Denchfield <td_denchfield@yahoo.com>
>> >> wrote:
>> >> > Hello,
>> >> >
>> >> > Tejun, this CF card adapter plugs directly
>> into an IDE
>> >> socket (Channel 0, in my case) on a desktop
>> computer
>> >> motherboard.=A0 You can see a picture of the
>> adapter in the
>> >> following URL01:
>> >> >
>> >> > URL01: http://preview.tinyurl.com/233u92u
>> >> >
>> >> > I have to power the adapter with a floppy
>> drive power
>> >> plug because my motherboard's IDE sockets were
>> intentionally
>> >> manufactured without the pin that could have
>> supplied power
>> >> through an IDE cable.
>> >> >
>> >> > Does anyone have a top of the head opinion as
>> to
>> >> whether there are inherent usage limitations in
>> either this
>> >> passive CF card adapter and/or in the Linux kernel
>> used with
>> >> Ubuntu v10.10 that would prevent users with CF
>> cards faster
>> >> than UDMA/66 (see URL02 below) from being
>> configured by
>> >> Linux to work at speeds above UDMA/66? =A0The
>> reason that I
>> >> ask this question is that I bought both my UDMA/66
>> CF card
>> >> and the adapter from the URL01 seller.=A0 It is
>> foreseeable
>> >> that a lot of customers might have purchased
>> faster CF cards
>> >> envisioning that they would work at speeds higher
>> than
>> >> UDMA/66 with the adapter.=A0 The 'Technical
>> Details' section
>> >> of URL01 does not state anything about UDMA speed
>> usage
>> >> limitations.
>> >> >
>> >> > URL02: http://www.hjreggel.net/cardspeed/index.html
>> >> >
>> >> > I think that there are CF card adapters on
>> eBay that
>> >> are similar to the one pictured in URL01 above,
>> and there
>> >> are also IDE adapters that will hold two CF
>> cards.
>> >>
>> >> The reason the speed is being limited to 33 is
>> that the
>> >> cable
>> >> detection code is detecting that an 80-wire cable
>> doesn't
>> >> appear to be
>> >> connected. In order for an 80-wire cable to be
>> detected,
>> >> pin 34 on the
>> >> cable is supposed to be grounded at the
>> motherboard end. In
>> >> the case
>> >> of this adapter, since it plugs directly into the
>> >> motherboard, it
>> >> would have to be grounding pin 34 to get an
>> 80-wire
>> >> detection, but
>> >> presumably it's not.
>> >>
>> >> >
>> >> > Tom
>> >> >
>> >> > --- On Wed, 1/5/11, Tejun Heo <htejun@gmail.com>
>> >> wrote:
>> >> >
>> >> >> From: Tejun Heo <htejun@gmail.com>
>> >> >> Subject: Re: CF Card Adapter White List
>> Candidate
>> >> >> To: "Robert Hancock" <hancockrwd@gmail.com>
>> >> >> Cc: "Tom Denchfield" <td_denchfield@yahoo.com>,
>> >> linux-ide@vger.kernel.org
>> >> >> Date: Wednesday, January 5, 2011, 5:51
>> AM
>> >> >> Hello,
>> >> >>
>> >> >> On Tue, Jan 04, 2011 at 10:19:17PM -0600,
>> Robert
>> >> Hancock
>> >> >> wrote:
>> >> >> > On 01/04/2011 04:18 PM, Tom
>> Denchfield
>> >> wrote:
>> >> >> >> As you further recommended, in
>> an attempt
>> >> to get
>> >> >> the SD-CF-IDE-DI
>> >> >> >> IDE to CF Adapter that holds my
>> CF card
>> >> white
>> >> >> listed, I am
>> >> >> >> submitting the attached
>> >> >> >>
>> >> >>
>> >>
>> libata_force_80c_CF_card_adapter_whitelist_candidate_information.txt
>> >> >> >> file that has the output from
>> executing
>> >> four
>> >> >> terminal commands to
>> >> >> >> hopefully supply enough
>> information to
>> >> get it
>> >> >> whitelisted.
>> >> >>
>> >> >> Thanks.
>> >> >>
>> >> >> >> Although I expect that my RV280
>> Radeon
>> >> 9200 Pro
>> >> >> video card is too
>> >> >> >> old to expend much effort on, it
>> would be
>> >> nice to
>> >> >> also get it
>> >> >> >> whitelisted so that future
>> newbie Linux
>> >> users who
>> >> >> do not know about
>> >> >> >> using the radeon.modeset=3D0
>> parameter on
>> >> the kernel
>> >> >> command line
>> >> >> >> will not be looking at a black
>> screen
>> >> with a
>> >> >> blinking cursor when
>> >> >> >> they attempt to use a LiveCD
>> for
>> >> troubleshooting,
>> >> >> or whatever.
>> >> >> >>
>> >> >> >> I purposely did not include the
>> URL of
>> >> one of the
>> >> >> Internet sites
>> >> >> >> that sells the adapter in this
>> email in
>> >> case this
>> >> >> is a no no.
>> >> >>
>> >> >> I don't think that's a no no unless the
>> intention
>> >> is
>> >> >> commercial.
>> >> >>
>> >> >> >> Tejun, I am not sure that I will
>> have
>> >> either the
>> >> >> time or the
>> >> >> >> interest to learn the
>> intricacies of
>> >> editing
>> >> >> >> http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive
>> >> >> to add
>> >> >> >> libata.force=3D80c to this site in
>> lieu of
>> >> >> force_cbl=3D80: so that
>> >> >> >> fewer people will be asking you
>> >> questions.=A0 I
>> >> >> have a ThinkPad
>> >> >> >> without a HDD plus a laptop
>> adapter that
>> >> will hold
>> >> >> my CF card, but
>> >> >> >> my Think Pad is a lot older than
>> the
>> >> ones
>> >> >> discussed on
>> >> >> >> Compact_Flash_boot_drive.=A0 In
>> addition,
>> >> I did
>> >> >> not see any recent
>> >> >> >> updates to this Internet page,
>> but maybe
>> >> I can
>> >> >> find someone to
>> >> >> >> email who will update this
>> page.
>> >> >>
>> >> >> Yeah, just ping someone.
>> >> >>
>> >> >> > Is there actually any way to
>> identify the
>> >> adapter
>> >> >> automatically?
>> >> >> > AFAIK, these CF-IDE adapters are
>> just
>> >> passive
>> >> >> circuitry and there's
>> >> >> > no way to identify them through
>> software.
>> >> >>
>> >> >> Hmmm... I was thinking this was somehing
>> >> integrated to the
>> >> >> machine (so
>> >> >> the dmidecode), in which case we can
>> combine dmi +
>> >> pci
>> >> >> function # +
>> >> >> port # to whitelist the device, which we
>> already
>> >> do for
>> >> >> some type of
>> >> >> quirks.=A0 If it's a plug in device, we
>> obviously
>> >> can't
>> >> >> identify it.
>> >> >> Tom, is the CF slot integrated to the
>> machine or
>> >> is it
>> >> >> something you
>> >> >> put into the PCMCIA slot?
>> >> >>
>> >> >> Thanks.
>> >> >>
>> >> >> --
>> >> >> tejun
>> >> >>
>> >> >
>> >> >
>> >> >
>> >> >
>> >>
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>> >
>>
>
>
>
>
>
