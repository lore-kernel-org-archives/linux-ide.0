From: Tim Small <tim@buttersideup.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 09 Apr 2010 11:12:49 +0100
Message-ID: <4BBEFDA1.5050607@buttersideup.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>	 <4bbdde49.e302be0a.3106.0220@mx.google.com>	 <20100408145916.50dbe8de@lxorguk.ukuu.org.uk>	 <4bbde1ea.c701be0a.60ec.0270@mx.google.com>	 <20100408150920.5689564b@lxorguk.ukuu.org.uk>	 <4bbde4f7.1702be0a.5f6c.028e@mx.google.com>	 <4BBE6CA6.1010808@gmail.com>	 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>	 <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>	 <4bbe8f84.1502be0a.0f89.0f16@mx.google.com> <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:39596 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504Ab0DIKM4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 06:12:56 -0400
In-Reply-To: <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> We can detect an AHCI-capable Intel chipsets (in most cases anyway),
> but problem is that a lot of systems with such chipsets, especially
> laptops, unfortunately have no way to actually put the controller into
> AHCI mode (no BIOS option for it). We could whine about it, but in a
> lot of cases there's not much that can be done about it..
>   

I have a couple of machines with those BIOSes, and apart from the fact
that the Intel ICH datasheets say something like "none but the saintly
BIOS writers shall program this register", it does seem to be possible
to put an ICH9R into AHCI mode using setpci and the fake hot plug driver...

I just wondered what the potential pitfalls might be of doing this? 
Obviously you wouldn't want to be doing anything with the controller at
the time that you change it's mode.  Is there also the risk of the
bloody bios fiddling with the device after the OS has booted (and then
getting surprised about it no longer being in piix mode)?

Cheers,

Tim.
