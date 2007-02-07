From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG?] ata disk running maximum at DMA33 with 2.6.20 and new
 pata driver, NV CK804 ide controller.
Date: Wed, 7 Feb 2007 12:20:00 +0000
Message-ID: <20070207122000.2e17ecb6@localhost.localdomain>
References: <200702070119.36320.genoni@darkstar.oltrelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161269AbXBGMHV@vger.kernel.org>
In-Reply-To: <200702070119.36320.genoni@darkstar.oltrelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luigi Genoni <genoni@sns.it>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com, alan@red-hat.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 7 Feb 2007 01:19:36 +0100
Luigi Genoni <genoni@sns.it> wrote:

> Hi,
> since upgrading to kernel 2.6.20 my pata disk, using new pata driver, is
> initialized maximum  in DMA33 mode (and obviously performances drop 
> consequently), as you can see from:

Interesting.

> Willing to test any patch.

Firstly can you see if its consistently the case that booting 2.6.20
gives UDMA33 and 2.6.19 UDMA100 over a few reboots. If it is please drop
the 2.6.19 drivers/ata/pamd_amd into 2.6.20 and try that.

Thanks

Alan
