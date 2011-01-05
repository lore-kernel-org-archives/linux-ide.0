From: Tom Denchfield <td_denchfield@yahoo.com>
Subject: Re: CF Card Adapter White List Candidate
Date: Wed, 5 Jan 2011 10:18:55 -0800 (PST)
Message-ID: <369064.19710.qm@web112003.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm12-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.242]:36713 "HELO
	nm12-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751211Ab1AESS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Jan 2011 13:18:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hello,

Tejun, this CF card adapter plugs directly into an IDE socket (Channel =
0, in my case) on a desktop computer motherboard.=A0 You can see a pict=
ure of the adapter in the following URL01:

URL01: http://preview.tinyurl.com/233u92u

I have to power the adapter with a floppy drive power plug because my m=
otherboard's IDE sockets were intentionally manufactured without the pi=
n that could have supplied power through an IDE cable.

Does anyone have a top of the head opinion as to whether there are inhe=
rent usage limitations in either this passive CF card adapter and/or in=
 the Linux kernel used with Ubuntu v10.10 that would prevent users with=
 CF cards faster than UDMA/66 (see URL02 below) from being configured b=
y Linux to work at speeds above UDMA/66?  The reason that I ask this qu=
estion is that I bought both my UDMA/66 CF card and the adapter from th=
e URL01 seller.=A0 It is foreseeable that a lot of customers might have=
 purchased faster CF cards envisioning that they would work at speeds h=
igher than UDMA/66 with the adapter.=A0 The 'Technical Details' section=
 of URL01 does not state anything about UDMA speed usage limitations.=20

URL02: http://www.hjreggel.net/cardspeed/index.html

I think that there are CF card adapters on eBay that are similar to the=
 one pictured in URL01 above, and there are also IDE adapters that will=
 hold two CF cards.

Tom

--- On Wed, 1/5/11, Tejun Heo <htejun@gmail.com> wrote:

> From: Tejun Heo <htejun@gmail.com>
> Subject: Re: CF Card Adapter White List Candidate
> To: "Robert Hancock" <hancockrwd@gmail.com>
> Cc: "Tom Denchfield" <td_denchfield@yahoo.com>, linux-ide@vger.kernel=
=2Eorg
> Date: Wednesday, January 5, 2011, 5:51 AM
> Hello,
>=20
> On Tue, Jan 04, 2011 at 10:19:17PM -0600, Robert Hancock
> wrote:
> > On 01/04/2011 04:18 PM, Tom Denchfield wrote:
> >> As you further recommended, in an attempt to get
> the SD-CF-IDE-DI
> >> IDE to CF Adapter that holds my CF card white
> listed, I am
> >> submitting the attached
> >>
> libata_force_80c_CF_card_adapter_whitelist_candidate_information.txt
> >> file that has the output from executing four
> terminal commands to
> >> hopefully supply enough information to get it
> whitelisted.
>=20
> Thanks.
>=20
> >> Although I expect that my RV280 Radeon 9200 Pro
> video card is too
> >> old to expend much effort on, it would be nice to
> also get it
> >> whitelisted so that future newbie Linux users who
> do not know about
> >> using the radeon.modeset=3D0 parameter on the kernel
> command line
> >> will not be looking at a black screen with a
> blinking cursor when
> >> they attempt to use a LiveCD for troubleshooting,
> or whatever.
> >>
> >> I purposely did not include the URL of one of the
> Internet sites
> >> that sells the adapter in this email in case this
> is a no no.
>=20
> I don't think that's a no no unless the intention is
> commercial.
>=20
> >> Tejun, I am not sure that I will have either the
> time or the
> >> interest to learn the intricacies of editing
> >> http://www.thinkwiki.org/wiki/Compact_Flash_boot_drive
> to add
> >> libata.force=3D80c to this site in lieu of
> force_cbl=3D80: so that
> >> fewer people will be asking you questions.=A0 I
> have a ThinkPad
> >> without a HDD plus a laptop adapter that will hold
> my CF card, but
> >> my Think Pad is a lot older than the ones
> discussed on
> >> Compact_Flash_boot_drive.=A0 In addition, I did
> not see any recent
> >> updates to this Internet page, but maybe I can
> find someone to
> >> email who will update this page.
>=20
> Yeah, just ping someone.
>=20
> > Is there actually any way to identify the adapter
> automatically?
> > AFAIK, these CF-IDE adapters are just passive
> circuitry and there's
> > no way to identify them through software.
>=20
> Hmmm... I was thinking this was somehing integrated to the
> machine (so
> the dmidecode), in which case we can combine dmi + pci
> function # +
> port # to whitelist the device, which we already do for
> some type of
> quirks.=A0 If it's a plug in device, we obviously can't
> identify it.
> Tom, is the CF slot integrated to the machine or is it
> something you
> put into the PCMCIA slot?
>=20
> Thanks.
>=20
> --=20
> tejun
>


     =20
