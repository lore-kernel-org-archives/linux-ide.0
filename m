From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: libata not working for sis5533
Date: Sat, 8 Sep 2007 12:45:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709081243050.25942@fbirervta.pbzchgretzou.qr>
References: <46D132C5.5000803@gmail.com> <6bffcb0e0708261627s12e5a9acqef92d0261264a40c@mail.gmail.com>
 <46D8921E.3010304@gmail.com> <46D89429.7080802@gmail.com>
 <20070902114032.7dbfb21a@the-village.bc.nu>
 <Pine.LNX.4.64.0709031957390.24179@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0709061156220.25942@fbirervta.pbzchgretzou.qr>
 <46E26DAF.9020906@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753363AbXIHKpr@vger.kernel.org>
In-Reply-To: <46E26DAF.9020906@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org


On Sep 8 2007 11:38, Patrizio Bassi wrote:
>Jan Engelhardt wrote:
>>
>> I shall give this a spin too, since I happen to have sis5513.
>>
>> Just booted this fresh ata-enabled system (a matter of mkinitrd). It has 
>>not exploded yet.
>
>don't you have the "irq 14" issue?

No, does not seem so.

>can you post here your .config?

http://rafb.net/p/vfTX0966.html

Maybe it is solved in 2.6.22.3? (I don't remember what your version 
was.)


	Jan
-- 
