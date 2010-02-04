From: Grant Grundler <grundler@google.com>
Subject: Re: port multiplier problem
Date: Thu, 4 Feb 2010 09:59:14 -0800
Message-ID: <da824cf31002040959y63f3484cv6d551acd49b80fa7@mail.gmail.com>
References: <4B5885F7.2020007@gmail.com> <4B6833DD.1020001@gmail.com>
	 <4B683581.7070708@kernel.org> <4B683DEF.3000302@gmail.com>
	 <da824cf31002020844r12cada26x57f96b0aa24b59c6@mail.gmail.com>
	 <4B686B2B.2080406@gmail.com>
	 <da824cf31002021104v72efcd05ne639091042d5999d@mail.gmail.com>
	 <4B687B7C.2070406@gmail.com>
	 <da824cf31002031837t1cf2357bsbb53a3b4ea5e671f@mail.gmail.com>
	 <4B6A3DED.6060708@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:42711 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab0BDR7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2010 12:59:18 -0500
In-Reply-To: <4B6A3DED.6060708@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Chandra Shekhar Sah <edu4madh@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 3, 2010 at 7:24 PM, Tejun Heo <tj@kernel.org> wrote:
> On 02/04/2010 11:37 AM, Grant Grundler wrote:
>> I had two questions on that thread that never got answered:
>> =C2=A0 =C2=A0http://markmail.org/message/snpekoj4qexrslk5
>>
>> | How can we find out if anyone has the SEMB properly wired up?
>> | Would it be hard to make libata aware of "SEMB port not responding=
" case?
>> | ie if the SEMB port times out or has no link, reduce the port coun=
t of
>> | the sil3726 PMP by one.
>> |
>> | Maybe add a "enable_sil24_semb" flag to libata?
>> | (avoid checking unless someone asks for it). I hate magic flags bu=
t also
>> | don't want to subject most people to the timeout delay.
>>
>> I (or Gwendal) can post a patch (and lightly test) for any of the ab=
ove.
>> Just need to get some guidance so we don't waste our time.
>
> It's not really sil24 tho. =C2=A0But anyways, I think we can just dis=
able
> them altogether. =C2=A0It's not like they have ever worked. =C2=A0Jus=
t limiting
> both 3726 and 4726 to 5 ports should be fine.

Sorry - You are right. I meant "enable_sil3726_semb".

I'm not sure we need to limit the SEMB ports anymore either. See below.

> =C2=A0That said, I'm not
> quite sure this is relevant to the reported problem but it's worth a
> shot.

I didn't have a better idea.

I'm seeing this in sata_pmp_quirks() since ATA_LFLAG_NO_SRST was introd=
uced:
 337 static void sata_pmp_quirks(struct ata_port *ap)
 338 {
 339         u32 *gscr =3D ap->link.device->gscr;
 340         u16 vendor =3D sata_pmp_gscr_vendor(gscr);
 341         u16 devid =3D sata_pmp_gscr_devid(gscr);
 342         struct ata_link *link;
 343
 344         if (vendor =3D=3D 0x1095 && devid =3D=3D 0x3726) {
 345                 /* sil3726 quirks */
 346                 ata_for_each_link(link, ap, EDGE) {
 347                         /* Class code report is unreliable and SRS=
T
 348                          * times out under certain configurations.
 349                          */
 350                         if (link->pmp < 5)
 351                                 link->flags |=3D ATA_LFLAG_NO_SRST=
 |
 352                                                ATA_LFLAG_ASSUME_AT=
A;
 353
 354                         /* port 5 is for SEMB device and it
doesn't like SR     ST */
 355                         if (link->pmp =3D=3D 5)
 356                                 link->flags |=3D ATA_LFLAG_NO_SRST=
 |
 357                                                ATA_LFLAG_ASSUME_SE=
MB;
 358                 }


But the ATA_LFLAG_NO_SRST used in line 351 is not present in the
2.6.26 tree I know works with PMPs. The original commit comment isn't
specific about exactly which HW had problems:
    http://www.mail-archive.com/git-commits-head@vger.kernel.org/msg243=
35.html

   "Some links on some PMPs locks up on SRST and/or report incorrect
    device signature.  Implement ATA_LFLAG_NO_SRST, ASSUME_ATA and
    ASSUME_SEMB to handle these quirky links.  NO_SRST makes EH avoid
    SRST.  ASSUME_ATA and SEMB forces class code to ATA and SEMB_UNSUP
    respectively.  Note that SEMB isn't currently supported yet so the
    _UNSUP variant is used."


Can you publish which PMP implementations sometimes lock up on SRST?

I doubt this is related to the problem Chandra is seeing but again,
don't have better ideas.

BTW, this same kernel works fine without disabling port 5 (SEMB port).
I didn't know
this until I just looked. I know previous source trees Google used
ignored SEMB port
on 3726 and I mistakenly assumed this one did too. :(

thanks,
grant
