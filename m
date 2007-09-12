From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: libata not working for sis5533
Date: Wed, 12 Sep 2007 22:01:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709122201100.32380@fbirervta.pbzchgretzou.qr>
References: <46D132C5.5000803@gmail.com> <6bffcb0e0708261627s12e5a9acqef92d0261264a40c@mail.gmail.com>
 <46D8921E.3010304@gmail.com> <46D89429.7080802@gmail.com>
 <20070902114032.7dbfb21a@the-village.bc.nu>
 <Pine.LNX.4.64.0709031957390.24179@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0709061156220.25942@fbirervta.pbzchgretzou.qr>
 <46E26DAF.9020906@gmail.com> <Pine.LNX.4.64.0709081243050.25942@fbirervta.pbzchgretzou.qr>
 <46E3DA7E.7060709@gmail.com> <20070911154658.ab1fe162.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0709122018400.22467@fbirervta.pbzchgretzou.qr>
 <46E834A2.2020205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46E834A2.2020205@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Sep 12 2007 20:49, Patrizio Bassi wrote:
>>>>       
>>> Looks more like a platform irq routing issue than an ata issue.
>>>
>>> Perhaps an x86 or an acpi person can help out with this.
>>
>> Patrizio, have you tried with the old IDE? (And without suspend at that...)
>
>yes yes old IDE works ok, but the suspend functionality is broken....

Well, that is a starting point. Now it is time for some ide dev :)



	Jan
-- 
