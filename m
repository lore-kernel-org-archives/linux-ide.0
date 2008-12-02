From: "David Ellingsworth" <david@identd.dyndns.org>
Subject: Re: Promise PDC20376
Date: Tue, 2 Dec 2008 08:36:25 -0500
Message-ID: <30353c3d0812020536t2074842lf4f1a1ef469f914f@mail.gmail.com>
References: <30353c3d0810240704n7476cc50y28b3eb8a5f326626@mail.gmail.com>
	 <30353c3d0811250616o733fb7f9ob4af96dd604f78ea@mail.gmail.com>
	 <18732.3809.720247.329641@harpo.it.uu.se>
	 <30353c3d0812011743we0bdddk2c9c37dd0191cf2a@mail.gmail.com>
	 <20081202105053.1bd78897@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:27003 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbYLBNg1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2008 08:36:27 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1283001eyi.37
        for <linux-ide@vger.kernel.org>; Tue, 02 Dec 2008 05:36:25 -0800 (PST)
In-Reply-To: <20081202105053.1bd78897@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 2, 2008 at 5:50 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> A small update to this. It seems the above mentioned interrupt fails
>> somewhere around the 128GB boundary. Interrupt 13h, AH=42 uses a 64
>> bit sector address and should be capable of addressing the entire
>> drive. For a SATA controller, this limitation seems relatively
>> arbitrary. For IDE controllers, a limitation such as this is
>> apparently common.
>
> 137GB I would imagine. That is the point at which LBA48 commands must be
> used not LBA28 and presumably their BIOS code only supports old format
> commands
>

Right, with LBA28 addressing you get 2^28 sector addresses = 2^27 KiB
= 2^17 MiB = 2^7 GiB = 128 GiB which is approximately 137GB. When I
wrote 128GB I really meant 128 GiB.

Regards,

David Ellingsworth

P.S. I hate the "new" binary size notations they only cause confusion.
