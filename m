From: Tejun Heo <htejun@gmail.com>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 15 Nov 2007 12:32:14 +0900
Message-ID: <473BBDBE.7060208@gmail.com>
References: <e03b90ae0711132239l258677fbk724204998078a952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:45892 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbXKODcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 22:32:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so477646wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 19:32:22 -0800 (PST)
In-Reply-To: <e03b90ae0711132239l258677fbk724204998078a952@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Breidenbach <jeff@jab.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>

Jeff Breidenbach wrote:
> I read with interest I. Straford's current trials and tribulations
> with the Promise SATA300 TX4. Do people have a favorite
> alternative to this card that plays well with Linux? I've read the
> chipset compatibility list, but am not sure how to boil that
> information down to an actual buyable SATA controller.
> 
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg12398.html
> http://linux-ata.org/driver-status.html

It's a sort of a difficult question to answer but I think it'll be nice
to develop a standard answer to this kind of question and put it on
linux-ata.org so that users can choose.  It can also hopefully work as
another pressure for vendors to enhance their linux support.

Anyways, here are what I know.

* ata_piix: Although it lacks shiny new features (interface limitation),
it should work pretty well.  No known serious bugs.

* ahci: Well supported.  Command switching PMP support is merged for
2.6.24 too.  Many (if not most) vendors now use ahci as programming
interface for storage controllers, so ahci driver supports lots of
controllers from many vendors.  Bugginess depends on which vendor or
chip you're actually using but in general all are well supported and if
you report a problem, it's very likely to get fixed soon.

* sata_sil: 3112 chips have problem with early seagate drives but both
3112 itself and those drives have been discontinued for a long time now.
 There are reports of data corruption when 3114 is connected to mobos
with NVidia chipsets.  This is still being investigated.  If you're on
intel mobo, 3112/3114/3512 should work good.

* sata_sil24: 3124/3132 chips don't have any outstanding serious
problems.  IRQ loss on PCI-X was the only recent serious known problem
but it's fixed now.  These chips are pretty advanced and all the
advanced features are supported by Linux including FIS switching PMP
support (will be included in 2.6.24 release); however, there is a known
hardware performance limitation so you can't use full SATA bandwidth
even if you use PMP but it's more than sufficient for most cases and
this chip is my personal favorite.

* sata_promise: Generally works okay; however there are still some
problems with recent 3Gbps chips. (Mikael, please pitch in)

* sata_nv: Generally works okay but ADMA support still seems to have
some problems (Robert?).

* sata_inic162x: Has half-working driver.  We need more info from the
vendor to proceed further.  Stay away from it for now.

* sata_via: Works okay.  No known serious problems but the chip is
quirky and not too dependable when errors occur.

* marvell ones: I don't have much idea.  Jeff?  Mark?

-- 
tejun
