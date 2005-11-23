From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Wed, 23 Nov 2005 16:39:16 -0500
Message-ID: <4384E184.3040304@pobox.com>
References: <437D2DED.5030602@pobox.com> <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de> <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932545AbVKWVjb@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bogdan Costescu wrote:
> On Fri, 18 Nov 2005, Jeff Garzik wrote:
> 
>> Yes, for both 50xx and 60xx, I had to turn off MSI in order to get
>> sata_mv to work...
> 
> 
> With MSI and libata DEBUG turned off I had a crash - solid one, SysRQ 
> doesn't work. I have forgotten to set console to serial port when 
> booting this kernel, so what follows is what I had on the screen, 
> hopefully without any typos (and without the initial addresses):

I wonder if the global reset disables MSI...  may be a driver bug.

You could play around with moving the pci_enable_msi until after the 
global reset...

	Jeff
