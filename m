From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: stable basic 4-port SATA card
Date: Wed, 14 Nov 2007 22:16:04 -0600
Message-ID: <473BC804.9030008@shaw.ca>
References: <e03b90ae0711132239l258677fbk724204998078a952@mail.gmail.com>
 <473BBDBE.7060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:32150 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbXKOESW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 23:18:22 -0500
Received: from pd4mr1so.prod.shaw.ca
 (pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRJ00GXK56WQIC0@l-daemon> for linux-ide@vger.kernel.org; Wed,
 14 Nov 2007 21:16:08 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JRJ00IOR56U5060@pd4mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 14 Nov 2007 21:16:07 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRJ00F3U56TNK50@l-daemon> for linux-ide@vger.kernel.org; Wed,
 14 Nov 2007 21:16:06 -0700 (MST)
In-reply-to: <473BBDBE.7060208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Breidenbach <jeff@jab.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Jeff Breidenbach wrote:
>> I read with interest I. Straford's current trials and tribulations
>> with the Promise SATA300 TX4. Do people have a favorite
>> alternative to this card that plays well with Linux? I've read the
>> chipset compatibility list, but am not sure how to boil that
>> information down to an actual buyable SATA controller.
>>
>> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg12398.html
>> http://linux-ata.org/driver-status.html
> 
> It's a sort of a difficult question to answer but I think it'll be nice
> to develop a standard answer to this kind of question and put it on
> linux-ata.org so that users can choose.  It can also hopefully work as
> another pressure for vendors to enhance their linux support.
> 
> Anyways, here are what I know.
> 
> * ata_piix: Although it lacks shiny new features (interface limitation),
> it should work pretty well.  No known serious bugs.
> 
> * ahci: Well supported.  Command switching PMP support is merged for
> 2.6.24 too.  Many (if not most) vendors now use ahci as programming
> interface for storage controllers, so ahci driver supports lots of
> controllers from many vendors.  Bugginess depends on which vendor or
> chip you're actually using but in general all are well supported and if
> you report a problem, it's very likely to get fixed soon.
> 
> * sata_sil: 3112 chips have problem with early seagate drives but both
> 3112 itself and those drives have been discontinued for a long time now.
>  There are reports of data corruption when 3114 is connected to mobos
> with NVidia chipsets.  This is still being investigated.  If you're on
> intel mobo, 3112/3114/3512 should work good.
> 
> * sata_sil24: 3124/3132 chips don't have any outstanding serious
> problems.  IRQ loss on PCI-X was the only recent serious known problem
> but it's fixed now.  These chips are pretty advanced and all the
> advanced features are supported by Linux including FIS switching PMP
> support (will be included in 2.6.24 release); however, there is a known
> hardware performance limitation so you can't use full SATA bandwidth
> even if you use PMP but it's more than sufficient for most cases and
> this chip is my personal favorite.
> 
> * sata_promise: Generally works okay; however there are still some
> problems with recent 3Gbps chips. (Mikael, please pitch in)
> 
> * sata_nv: Generally works okay but ADMA support still seems to have
> some problems (Robert?).

There aren't many in the way of specific known problems that aren't 
worked around. There was a hotplug issue that was reported (kernel bug 
8421), but only seems to happen on a certain revision of MSI Neo4 
Platinum board so I suspect it's a board issue. Also there's the 
ATAPI/>4GB RAM issue that's being debugged. But I haven't seen many 
reports pointing to driver problems.

As far as the poster's question, these controllers are all built into 
the chipset, so it's not really relevant to their issue..

> 
> * sata_inic162x: Has half-working driver.  We need more info from the
> vendor to proceed further.  Stay away from it for now.
> 
> * sata_via: Works okay.  No known serious problems but the chip is
> quirky and not too dependable when errors occur.
> 
> * marvell ones: I don't have much idea.  Jeff?  Mark?
> 
