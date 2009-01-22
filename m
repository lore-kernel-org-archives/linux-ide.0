From: Dmitry Gryazin <gdu@mns.spb.ru>
Subject: Re: [PATCH] ide: motherboard-info based blacklist for ide-dma
Date: Thu, 22 Jan 2009 17:27:35 +0300
Message-ID: <200901221727.35574.gdu@mns.spb.ru>
References: <1230651239-29388-1-git-send-email-kirr@mns.spb.ru> <49787A85.6000001@ru.mvista.com> <49787B98.8060106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:33969 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbZAVOcP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 09:32:15 -0500
In-Reply-To: <49787B98.8060106@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kirill Smelkov <kirr@mns.spb.ru>, linux-ide@vger.kernel.org, navy-patches@mns.spb.ru

On Thursday 22 January 2009 04:58:48 pm Sergei Shtylyov wrote:
> Hello, I wrote:
> >>>>>>>> True.  However it should be possible to handle it correctly by
> >>>>>>>> adding
> >>>>>>>> the
> >>>>>>>> DMA quirk to the respective host drivers (seems to be
> >>>>>>>> via82cxxx.c in
> >>>>>>>> case of
> >>>>>>>> IEI PCISA-C3/EDEN).
> >>>>>>>
> >>>>>>>  Yeah, this seems a viable approach...
> >>>>>>>
> >>>>>>>> Kirill, could you please look into adding such quirk to via82cxxx
> >>>>>>>> instead?
> >>>>>>>>
> >>>>>>>> [ It seems the best place to add it would be via_init_one() as we
> >>>>>>>> could just
> >>>>>>>
> >>>>>>>  No, not really -- the issue is not at all as simple as this patch
> >>>>>>> tried to present it. Looking at its "Quick Startup Reference"
> >>>>>>> (http://f.ipc2u.ru/files/add/doc/496/M_PCISA-C800EV_ENG.pdf), the
> >>>>>>> EPIC
> >>>>>>> board has *two* normal IDE connectors in addition to the CF slot
> >>>>>>> (connected to the secondary port -- and it seems possible that a
> >>>>>>> hard
> >>>>>>> drive can be connected to the same port as CF), so the right place
> >>>>>>> seems to rather be in [mu]dma_filter() methods -- and the decision
> >>>>>>> should be strictly based on the drive type indicating CF, i.e. by
> >>>>>>> calling ata_id_is_cfa().
> >>>
> >>> I have tried my old Trancend 64Mb, RamStar 521Mb and NCP 64Mb cards.
> >>> My old cards returned right id[ATA_ID_CONFIG] = 0x848A.
> >>>
> >>> But I have to use Kingston CF Card 1Gb 2008.
> >>> ata_id_is_cfa() returns 0 for it and
> >>> id[ATA_ID_MAJOR_VER]    = 0
> >>> id[ATA_ID_CONFIG]        = 0x044A
> >>
> >>    That seems non-standard CF as ATA specifies that it must have
> >> 0x848A there.
> >>
> >>> I have only CF+ specification revision 2.0,  but I've found in wiki:
> >>
> >>    Try googling for cfspc_41.pdf (and other versions), you'll be
> >> surprised in a good way. ;-)
> >>
> >>> (http://en.wikipedia.org/wiki/CompactFlash#CF.2B_specification_revision
> >>>s)
> >>>
> >>> "... While the current revision 4.1 from 2004 works only in ATA mode,
> >>> ..."
> >>>
> >>> So I have reached an impasse. How to identify modern CF cards?
> >>
> >>    Hm, I should consult the specs...
> >
> >    ATA/PI-7 rev. 4b has this in 4.10:
> >
> > Devices reporting the value 848Ah in IDENTIFY DEVICE data word 0 or
> > devices having bit 2 of IDENTIFY DEVICE data word 83 set to one shall
> > support the CFA feature Set. If the CFA feature set is implemented, all
> > five commands shall be implemented.
> >
> >    Alan, looks like the libata's CF criterion needs to be enhanced.
>
>     Oops, my bad -- I should've looked first. :-<
>     Dmitry, just use the modern version of ata_id_is_cfa().

Sergei, I use the latest kernel from git repository 
(http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git), if 
you are talking about this patch:
37014c64079748c47fd109ef2d91ecd785a8c764

Regards, Dmitry
