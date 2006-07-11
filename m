From: Jeremy Jackson <jerj@coplanar.net>
Subject: Re: libata SATA support for Sil 3726 port multiplier
Date: Tue, 11 Jul 2006 12:24:22 -0400
Message-ID: <44B3D0B6.7070506@coplanar.net>
References: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bob.coplanar.net ([206.222.78.116]:20711 "EHLO bob.coplanar.net")
	by vger.kernel.org with ESMTP id S1751018AbWGKQYf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2006 12:24:35 -0400
In-Reply-To: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fredrik Sjoholm <fredrik@sjoholm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

What device do you have with a 3726?  I have tried contacting Silicon 
Image directly, but they do not know of any products that are *not* 
external eSATA enclosures.  If anyone knows of these (for sale - not 
demo boards), I'd like to hear about it.

Fredrik Sjoholm wrote:
> 
> Hello Jeff,
> 
> i'm using your libata SATA PMP support with a Sil 3132 chip + 3726 port 
> multiplier with 5 drives. in order to get it to work, i had to make the 
> following addition in ata_pm_quirks() [libata-pm.c]
