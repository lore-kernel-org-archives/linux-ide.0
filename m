From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: regarding ACPI support in 2.6.21
Date: Mon, 12 Mar 2007 17:01:10 +0000
Message-ID: <20070312170110.4911203d@lxorguk.ukuu.org.uk>
References: <45F5648C.7020506@gmail.com>
	<20070312154649.5f661a39@lxorguk.ukuu.org.uk>
	<45F56BD5.6040408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <45F56BD5.6040408@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> It sounds like your tree is out-of-date.  Your patch to fix that went in 
> days ago, applied by Linus directly:

Its purposefully not tracking every Linus update so I can build a
replicable environment. I missed the list mail it went in tho.

> I lean towards disabling it by default in 2.6.21 anyway, but am 
> interested in hearing an updated opinion on what's actually in the 
> public tree.

For PATA disable it, for SATA no opinion.

