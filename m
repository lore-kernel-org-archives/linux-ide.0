From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
	non-ATAPI data commands
Date: Sat, 22 Aug 2009 10:27:57 -0600
Message-ID: <51f3faa70908220927n2e05d73cwd7faf6389c56d06@mail.gmail.com>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com>
	 <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org>
	 <4A900DE6.2020802@rtr.ca> <4A900E87.5060207@rtr.ca>
	 <4A901871.7020206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:64354 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849AbZHVQ1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Aug 2009 12:27:55 -0400
Received: by pzk32 with SMTP id 32so323976pzk.33
        for <linux-ide@vger.kernel.org>; Sat, 22 Aug 2009 09:27:57 -0700 (PDT)
In-Reply-To: <4A901871.7020206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Sat, Aug 22, 2009 at 10:10 AM, Jeff Garzik<jeff@garzik.org> wrote:
> On 08/22/2009 11:28 AM, Mark Lord wrote:
>>
>> Mmm.. I wonder if something like this patch might also be applicable
>> to the sata_sil.c driver too?
>
>
> Not AFAICT. =A0The 3112 has a Command Protocol Table inside the chip.=
 Each
> command reads the ATA command protocol from that table. =A0The table =
is
> programmable (see section 10.3 of [1]), but not on a per-command basi=
s. =A0The
> per-command PRD format is pretty much legacy IDE[2], and nothing like=
 the
> modern FIS-based controllers.

I think it should be possible to send trim commands through the 311x,
but the protocol override is done differently, you'd have to send a VS
Set Command Protocol command in order to set the protocol code for
that command/feature combination to the correct DMA protcol code. It's
not quite as general a solution as with the 3124/3132 controllers (you
have to tell it specifically about each command it doesn't know
about). Also the set protocols get erased on COMINIT/COMRESET so you'd
have to redo the override post-reset.
