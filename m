From: Tom Denchfield <td_denchfield@yahoo.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Wed, 5 Jan 2011 21:33:53 -0800 (PST)
Message-ID: <186863.99156.qm@web112005.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm8.bullet.mail.ne1.yahoo.com ([98.138.90.71]:29549 "HELO
	nm8.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752486Ab1AFFdz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2011 00:33:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hello,

Robert, it looks like I may have found an answer to my UDMA speed quest=
ion (see below) that I asked earlier today.=A0 URL03 below has a pictur=
e (top-right) of an Addonics Dual CF-IDE HDD Adapter that looks to me l=
ike it can be connected to a motherboard IDE socket via a 80-wire IDE c=
able.=A0 (This adapter's IDE socket is not shown in the picture.  On se=
cond thought, maybe this device does not have a 40-pin IDE socket since=
 the article is about laptop computers.)=A0 The article says to use a (=
now) outdated patch, even with, I would guess, an 80-conductor IDE cabl=
e, to 'force 80c.'=A0 With the outdated patch, URL03 has a dmesg excerp=
t in a table that shows a UDMA/100 CF card being configured by Linux as=
 a UDMA/100 device.
=20
Title: Compact Flash boot drive
URL03: http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive

With my plug-in IDE adapter (pictured in URL01 below) that is plugged d=
irectly into a desktop computer's motherboard IDE socket, my UDMA/66 CF=
 Card is configured by the Linux version 2.6.35-22-generic kernel that =
is used by the Ubuntu v10.10 LiveCD that I use, as a UDMA/33 device.=A0=
 However, if I add libata.force=3D80c as a boot parameter, as recommend=
ed by Tejun, Linux configures my CF card as a UDMA/66 device.

(In the first email that I sent to linux-ide@vger.kernel.org, I attache=
d a dmesg demonstrating that the added boot parameter produced the UDMA=
/66 configuration.=A0 I attached two text files that I think totaled ab=
out 65KB, and maybe linux-ide@vger.kernel.org strips files of this size=
 from emails.=A0 I also do not expect anyone to remember that far back =
when answering my questions.)

I do not know whether the following dmesg is the one that I originally =
sent, but it is typical of what happens with the liabat.forec=3D80c par=
ameter:

[=A0 =A0 0.000000] Kernel command line: file=3D/cdrom/preseed/ubuntu.se=
ed boot=3Dcasper initrd=3D/casper/initrd.lz radeon.modeset=3D0 libata.f=
orce=3D80c toram --
=2E
[=A0 =A0 5.088368] ata3: FORCE: cable set to 80c
[=A0 =A0 5.088452] ata3.00: CFA: TS8GCF133, 20100804, max UDMA/66
[=A0 =A0 5.088509] ata3.00: 15662304 sectors, multi 0: LBA=20
[=A0 =A0 5.104301] ata3.00: configured for UDMA/66
=2E
[=A0 =A0 5.564449] scsi 2:0:0:0: Direct-Access=A0 =A0=A0=A0ATA=A0 =A0 =A0=
 TS8GCF133=A0 =A0 =A0 =A0 2010 PQ: 0 ANSI: 5
[=A0 =A0 5.564819] sd 2:0:0:0: Attached scsi generic sg1 type 0
[=A0 =A0 5.565631] sd 2:0:0:0: [sdb] 15662304 512-byte logical blocks: =
(8.01 GB/7.46 GiB)

The reason that I mentioned powering my CF adapter with a floppy drive =
power plug is that the first time I booted after inserting the adapter,=
 I forgot to plug the floppy drive power plug into the adapter.=A0 The =
adapter's power on LED did not light, and I think that Ubuntu did not s=
ee the CF card.

The reason that I mentioned the pin that was intentionally left out of =
the motherboard IDE socket was that I thought that the missing pin migh=
t have had something to do with needing to power the adapter with the f=
loppy drive power plug given my experience with forgetting to plug the =
floppy power plug into the adapter as mentioned in the previous paragra=
ph.

The pin that is missing from the motherboard IDE socket is very close t=
o the middle of the IDE socket.=A0 My guess is that the pin is in the i=
n the range #18 to #24.=A0 It is far away from pin #34.=A0 I am going b=
y memory here, but I clearly remember that the missing pin is in the mi=
ddle.=A0 Pin #34 is going into the CF card adapter when I insert it.=A0=
 I do not know whether pin #34 is grounded at the mainboard.

When I asked my question, before I noticed and paid any real attention =
to the UDMA/100 CF card configured as UDMA/100 in URL03 above, I was co=
ncerned that there might be a UDMA/66 speed limit with the type of CF c=
ard adapter that I have.  We may never know for sure until someone who =
has a CF card that is faster than UDMA/66 tries it in the URL01 adapter=
 with Linux and the libata.force=3D80c boot parameter.

Robert, thank you for helping me.  I hope that my additional comments a=
nd the information above will contribute to further Linux kernel develo=
pment.  =A0=20

Tom

--- On Wed, 1/5/11, Robert Hancock <hancockrwd@gmail.com> wrote:

> From: Robert Hancock <hancockrwd@gmail.com>
> Subject: Re: CF Card Adapter White List Candidate
> To: "Tom Denchfield" <td_denchfield@yahoo.com>
> Cc: "Tejun Heo" <htejun@gmail.com>, linux-ide@vger.kernel.org
> Date: Wednesday, January 5, 2011, 5:47 PM
> On Wed, Jan 5, 2011 at 12:18 PM, Tom
> Denchfield <td_denchfield@yahoo.com>
> wrote:
> > Hello,
> >
> > Tejun, this CF card adapter plugs directly into an IDE
> socket (Channel 0, in my case) on a desktop computer
> motherboard.=A0 You can see a picture of the adapter in the
> following URL01:
> >
> > URL01: http://preview.tinyurl.com/233u92u
> >
> > I have to power the adapter with a floppy drive power
> plug because my motherboard's IDE sockets were intentionally
> manufactured without the pin that could have supplied power
> through an IDE cable.
> >
> > Does anyone have a top of the head opinion as to
> whether there are inherent usage limitations in either this
> passive CF card adapter and/or in the Linux kernel used with
> Ubuntu v10.10 that would prevent users with CF cards faster
> than UDMA/66 (see URL02 below) from being configured by
> Linux to work at speeds above UDMA/66? =A0The reason that I
> ask this question is that I bought both my UDMA/66 CF card
> and the adapter from the URL01 seller.=A0 It is foreseeable
> that a lot of customers might have purchased faster CF cards
> envisioning that they would work at speeds higher than
> UDMA/66 with the adapter.=A0 The 'Technical Details' section
> of URL01 does not state anything about UDMA speed usage
> limitations.
> >
> > URL02: http://www.hjreggel.net/cardspeed/index.html
> >
> > I think that there are CF card adapters on eBay that
> are similar to the one pictured in URL01 above, and there
> are also IDE adapters that will hold two CF cards.
>=20
> The reason the speed is being limited to 33 is that the
> cable
> detection code is detecting that an 80-wire cable doesn't
> appear to be
> connected. In order for an 80-wire cable to be detected,
> pin 34 on the
> cable is supposed to be grounded at the motherboard end. In
> the case
> of this adapter, since it plugs directly into the
> motherboard, it
> would have to be grounding pin 34 to get an 80-wire
> detection, but
> presumably it's not.
>=20
> >
> > Tom
> >
> > --- On Wed, 1/5/11, Tejun Heo <htejun@gmail.com>
> wrote:
> >
> >> From: Tejun Heo <htejun@gmail.com>
> >> Subject: Re: CF Card Adapter White List Candidate
> >> To: "Robert Hancock" <hancockrwd@gmail.com>
> >> Cc: "Tom Denchfield" <td_denchfield@yahoo.com>,
> linux-ide@vger.kernel.org
> >> Date: Wednesday, January 5, 2011, 5:51 AM
> >> Hello,
> >>
> >> On Tue, Jan 04, 2011 at 10:19:17PM -0600, Robert
> Hancock
> >> wrote:
> >> > On 01/04/2011 04:18 PM, Tom Denchfield
> wrote:
> >> >> As you further recommended, in an attempt
> to get
> >> the SD-CF-IDE-DI
> >> >> IDE to CF Adapter that holds my CF card
> white
> >> listed, I am
> >> >> submitting the attached
> >> >>
> >>
> libata_force_80c_CF_card_adapter_whitelist_candidate_information.txt
> >> >> file that has the output from executing
> four
> >> terminal commands to
> >> >> hopefully supply enough information to
> get it
> >> whitelisted.
> >>
> >> Thanks.
> >>
> >> >> Although I expect that my RV280 Radeon
> 9200 Pro
> >> video card is too
> >> >> old to expend much effort on, it would be
> nice to
> >> also get it
> >> >> whitelisted so that future newbie Linux
> users who
> >> do not know about
> >> >> using the radeon.modeset=3D0 parameter on
> the kernel
> >> command line
> >> >> will not be looking at a black screen
> with a
> >> blinking cursor when
> >> >> they attempt to use a LiveCD for
> troubleshooting,
> >> or whatever.
> >> >>
> >> >> I purposely did not include the URL of
> one of the
> >> Internet sites
> >> >> that sells the adapter in this email in
> case this
> >> is a no no.
> >>
> >> I don't think that's a no no unless the intention
> is
> >> commercial.
> >>
> >> >> Tejun, I am not sure that I will have
> either the
> >> time or the
> >> >> interest to learn the intricacies of
> editing
> >> >> http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive
> >> to add
> >> >> libata.force=3D80c to this site in lieu of
> >> force_cbl=3D80: so that
> >> >> fewer people will be asking you
> questions.=A0 I
> >> have a ThinkPad
> >> >> without a HDD plus a laptop adapter that
> will hold
> >> my CF card, but
> >> >> my Think Pad is a lot older than the
> ones
> >> discussed on
> >> >> Compact_Flash_boot_drive.=A0 In addition,
> I did
> >> not see any recent
> >> >> updates to this Internet page, but maybe
> I can
> >> find someone to
> >> >> email who will update this page.
> >>
> >> Yeah, just ping someone.
> >>
> >> > Is there actually any way to identify the
> adapter
> >> automatically?
> >> > AFAIK, these CF-IDE adapters are just
> passive
> >> circuitry and there's
> >> > no way to identify them through software.
> >>
> >> Hmmm... I was thinking this was somehing
> integrated to the
> >> machine (so
> >> the dmidecode), in which case we can combine dmi +
> pci
> >> function # +
> >> port # to whitelist the device, which we already
> do for
> >> some type of
> >> quirks.=A0 If it's a plug in device, we obviously
> can't
> >> identify it.
> >> Tom, is the CF slot integrated to the machine or
> is it
> >> something you
> >> put into the PCMCIA slot?
> >>
> >> Thanks.
> >>
> >> --
> >> tejun
> >>
> >
> >
> >
> >
>









     =20
