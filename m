From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise PDC20376
Date: Tue, 2 Dec 2008 10:50:53 +0000
Message-ID: <20081202105053.1bd78897@lxorguk.ukuu.org.uk>
References: <30353c3d0810240704n7476cc50y28b3eb8a5f326626@mail.gmail.com>
	<30353c3d0811250616o733fb7f9ob4af96dd604f78ea@mail.gmail.com>
	<18732.3809.720247.329641@harpo.it.uu.se>
	<30353c3d0812011743we0bdddk2c9c37dd0191cf2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754585AbYLBKwH@vger.kernel.org>
In-Reply-To: <30353c3d0812011743we0bdddk2c9c37dd0191cf2a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ellingsworth <david@identd.dyndns.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> A small update to this. It seems the above mentioned interrupt fails
> somewhere around the 128GB boundary. Interrupt 13h, AH=42 uses a 64
> bit sector address and should be capable of addressing the entire
> drive. For a SATA controller, this limitation seems relatively
> arbitrary. For IDE controllers, a limitation such as this is
> apparently common.

137GB I would imagine. That is the point at which LBA48 commands must be
used not LBA28 and presumably their BIOS code only supports old format
commands
