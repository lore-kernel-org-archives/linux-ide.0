From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata errors
Date: Sat, 11 Apr 2009 12:00:32 -0600
Message-ID: <49E0DAC0.1030901@gmail.com>
References: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>	<49DBC889.3080304@pobox.com> <18908.23783.745239.601473@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:44634 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758110AbZDKSAi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 14:00:38 -0400
Received: by gxk4 with SMTP id 4so3395974gxk.13
        for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 11:00:36 -0700 (PDT)
In-Reply-To: <18908.23783.745239.601473@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Grice <mcjgrice@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > If its ahci, try using ata_piix.  I am beginning to think that ATAPI on 
>  > AHCI is broken.
> 
> I use a SATAPI DVD-writer on AHCI (Intel 965) on a semi-regular
> basis, and it's never had any issues with recent 2.6.2x kernels.

I tend to doubt that the driver is doing the wrong thing. I suspect it's 
more that ATAPI devices on SATA are about as standards-compliant in 
general as ATAPI devices on PATA (which is to say not very good) and 
some of them break if the controller does something slightly differently 
or with different timing, which is quite possible in AHCI mode.

Tejun was looking at some SATA analyzer traces of a few drives that were 
apparently failing consistently on AHCI. Tejun, did you get anywhere 
with this? Even if the trace doesn't reveal any invalid behavior, if it 
includes high-precision timing data it would be interesting to compare 
that to the results on a working controller..
