From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH] ahci: Add support for Promise PDC42819
Date: Tue, 02 Sep 2008 08:01:59 -0400
Message-ID: <48BD2B37.6060000@garzik.org>
References: <65a6ef750809020403i52228319u9e3197e4062941bc@mail.gmail.com>	<48BD2136.1020101@garzik.org> <20080902125310.729b0997@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20080902125310.729b0997@lxorguk.ukuu.org.uk>
Sender: linux-scsi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Nelson <mdnelson8@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Apparently this chip also supports SAS disks, will these work with the
>>> ahci driver (I've only tested with normal desktop SATA disks)?
>> ahci is definitely SATA-only, so I wonder how they modified AHCI to 
>> support SAS transport...
> 
> Jeff while are on that subject a further reminder - AHCI is also breaking
> Marvell PATA device support for this reason and we now have months of
> regressions because of that.

Refresh my memory...  what is the problem with loading pata_marvell first?

AFAICS, if you load pata_marvell before ahci, it will grab the PATA 
disks and the PCI device itself.

	Jeff


