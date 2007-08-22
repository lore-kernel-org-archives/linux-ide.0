From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Wed, 22 Aug 2007 17:48:52 +0200
Message-ID: <46CC5AE4.1090600@gmail.com>
References: <200708212149.12912.jopan@alumni.uv.es>	<46CB626F.8020801@gmail.com>	<200708220339.45138.jopan@alumni.uv.es>	<46CBA0F0.70503@gmail.com> <20070822122359.7ce8ddaa@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763161AbXHVPx5@vger.kernel.org>
In-Reply-To: <20070822122359.7ce8ddaa@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-15?Q?Jos=E9_Luis_Pati=F1o_Andr=E9s?= <jopan@alumni.uv.es>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 08/22/2007 01:23 PM, Alan Cox wrote:

>> The old SATA driver available from the IDE menu also does not support your 
>> chip, so I don't believe there are any workarounds -- you'll need the issue 
>> fixed.
> 
> What issue ?
> 
> From the report its quite simple - enable the correct CONFIG_ATA based
> drivers and it should all work fine.

He has a SATA harddrive and an IDE DVD drive. When he compiles with 
CONFIG_ATA_PIIX (a driver which advertises both SATA and PATA in its 
description) his drive works, his DVD does not. Is that not the correct 
driver? Does he need something else? How does he get his DVD to work?

Rene.
