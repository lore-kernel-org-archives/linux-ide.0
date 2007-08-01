From: Markus Gutschke <markus@gutschke.com>
Subject: Re: Marvell 7042 (sata_mv) fails to initialize drive
Date: Wed, 01 Aug 2007 13:53:51 -0700
Message-ID: <46B0F2DF.90608@gutschke.com>
References: <46AEAAB1.801@gutschke.com> <6bffcb0e0708011213q1c8908e2p1c87967745b977b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754381AbXHAUyP@vger.kernel.org>
In-Reply-To: <6bffcb0e0708011213q1c8908e2p1c87967745b977b5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I have done some more testing, and it now looks as if this was actually 
a hardware fault. Reseating the PCI-E card made the problem go away 
(knock on wood). I am a little puzzled that it is possible for the card 
to show up on the PCI bus, and for the driver to be able to detect 
whether a disk is connected, but then for it to fail to communicate with 
the disk. But oh well, I guess if just some of the PCI-E signals aren't 
connected, strange error modes are to be expected.

Sorry for the false alarm. And just for the record, if any you need any 
more testing done with 7042 controllers, feel free to ask me for help -- 
I think I read somewhere that Jeff was looking for testers that have 
access to this hardware.


Markus
