From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] IDE update
Date: Mon, 11 Jul 2005 15:21:47 +0100
Message-ID: <1121091705.7434.66.camel@localhost.localdomain>
References: <20050705101414.GB18504@suse.de>
	 <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de>
	 <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux>
	 <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux>
	 <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
	 <Pine.LNX.4.58.0507051016420.3570@g5.osdl.org>
	 <20050705191448.GB30235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261816AbVGKO2a@vger.kernel.org>
In-Reply-To: <20050705191448.GB30235@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Ondrej Zary <linux@rainbow-software.org>, =?ISO-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>, Al Boldi <a1426z@gawab.com>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-07-05 at 20:14, Jens Axboe wrote:
> IDE still has much lower overhead per command than your average SCSI
> hardware. SATA with FIS even improves on this, definitely a good thing!

But SCSI overlaps them while in PATA they are dead time. Thats why PATA
is so demanding of large I/O block sizes
