From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Subject: Re: [PATCH] ahci: get JMicron JMB360 working
Date: Sun, 29 Jan 2006 03:01:18 -0800
Message-ID: <pan.2006.01.29.11.01.17.108084@tbdnetworks.com>
References: <20060129050434.GA19047@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750932AbWA2Law@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 29 Jan 2006 00:04:34 -0500, Jeff Garzik wrote:

> 
> I'll be sending this upstream sooner rather than later, since part of
> this is a needed bugfix.  This is also a minor milestone:  the first
> non-Intel AHCI implementation is working with the AHCI driver.  AHCI is
> a nice SATA controller interface, and it's good to see other vendors
> using it.  VIA is using it as well, and I hope to integrate a patch for
> VIA AHCI SATA support soon.
> 
> This patch, against latest 2.6.16-rc-git, adds support for JMicron and
> fixes some code that should be Intel-only, but was being executed for
> all vendors.

Sounds very good, thanks! Does that mean the ASRock MB 
http://www.asrock.com/product/product_939Dual-SATA2.htm will work? Docu
says "1 x SATA2 connector (based on PCI E SATA2 controller JMB360)".

Best,
  Norbert
