From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 19/86] pata_cmd640: document known issues
Date: Wed, 25 Nov 2009 18:44:01 +0100
Message-ID: <200911251844.01227.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125172633.7a15711b@lxorguk.ukuu.org.uk> <4B0D6B4F.9030605@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922AbZKYRq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:46:59 -0500
In-Reply-To: <4B0D6B4F.9030605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:37:19 pm Jeff Garzik wrote:
> On 11/25/2009 12:26 PM, Alan Cox wrote:
> > On Wed, 25 Nov 2009 18:04:36 +0100
> > Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
> >
> >> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> >> Subject: [PATCH] pata_cmd640: document known issues
> >>
> >> Document known issues with the driver to aid distribution makers,
> >> users and developers in making informed decisions instead of wasting
> >> their time needlessly.
> >
> > Umm. its a) under CONFIG_PCI, and b) says CMD640 PCI IDE...
> 
> Agreed, that's a bit redundant.
> 
> Also, as I noted in another email, known issues should be listed in the 
> driver source code at the top of the file, not in Kconfig.

Agreed, since virtually everybody should be looking into source
code of each single driver before compiling kernel and/or deciding
to include it into distribution kernel.

--
Bartlomiej Zolnierkiewicz
