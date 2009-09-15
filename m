From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard ATP867X
  controllers
Date: Tue, 15 Sep 2009 01:38:05 +0100
Message-ID: <20090915013805.7f2fa251@lxorguk.ukuu.org.uk>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
	<1252721641.28368.34.camel@desktop>
	<8b5805ff0909120359g2faf661br463b19518d935110@mail.gmail.com>
	<4AABD122.2000400@gmail.com>
	<8b5805ff0909121717w1516c273k2a568779b9c31662@mail.gmail.com>
	<4AAC3EEA.1080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754567AbZIOOxM@vger.kernel.org>
In-Reply-To: <4AAC3EEA.1080605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Jung-Ik (John) Lee" <jilee@google.com>, Robert Hancock <hancockrwd@gmail.com>, Daniel Walker <dwalker@fifo99.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

> Ideally you would use ATA_CBL_PATA_UNK / ata_cable_unknown, but it seems 
> that ATA_CBL_PATA_UNK has grown rather useless in the current kernel.
> 
> We should probably (a) update libata-core/libata-sff to do something 
> intelligent with ATA_CBL_PATA_UNK,

It does - it says "Use drive side detect the controller hasn't got a
clue".

Alan
