From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 15:17:14 +0100
Message-ID: <200911191517.15090.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911182056.16517.bzolnier@gmail.com> <20091119131636.15800a11@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-1920.google.com ([74.125.92.150]:3832 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZKSOST (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 09:18:19 -0500
In-Reply-To: <20091119131636.15800a11@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 19 November 2009 14:16:36 Alan Cox wrote:
> > Only pata_hpt37x has broken cable detection while pata_hpt3x2n is
> > okay. ;)
> 
> I think you have that backwards according to the vendor drivers. 3x2n
> looks like it needs adjusting.

lol, just fix the damn pata_hpt37x driver _lacking_ ->cable_detect method..

-- 
Bartlomiej Zolnierkiewicz
