From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT821x: no DMA since 2.6.21
Date: Tue, 15 May 2007 12:31:32 +0100
Message-ID: <20070515123132.2e596d69@the-village.bc.nu>
References: <20070515125308.3a9f6442@SiRiUS.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934331AbXEOL1d@vger.kernel.org>
In-Reply-To: <20070515125308.3a9f6442@SiRiUS.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Kuther <gimpel@sonnenkinder.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 15 May 2007 12:53:08 +0200
Thomas Kuther <gimpel@sonnenkinder.org> wrote:

> Hi!
> 
> Since 2.6.21 I have a problem with the it821x driver on my ITE 8212
> controller.
> Now I saw some updates to it821x in 2.6.22-rc1 and gave that a try, but
> the problem persists.

I've had multiple reports of this. I would recommend you use the libata
driver. IT821x hasn't changed over the past few releases so its someting
in the core IDE code that broke it [note it might not of course be that
the problem is in the core code..].

I have no plans at this point to debug the old IT821x driver due to time
constraints, and if anyone wants to have a crack at debugging this and
fixing it go for it.

BTW: I also note you have the controller in smart mode but are not using
the hardware raid functions. In that situation it generally runs faster
(and does CD-ROM) if you flash the ATAPI firmware to the controller or
boot with the noraid option "it8212.noraid=1"

Alan
