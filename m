From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: review of pata-rb532-cf
Date: Sat, 24 Jan 2009 15:12:11 +0100
Message-ID: <200901241512.11657.bzolnier@gmail.com>
References: <20081128194607.93677386B1A7@mail.ifyouseekate.net> <20090120164314.07AD3400E137@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:62674 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbZAXOVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:21:18 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3284609muf.1
        for <linux-ide@vger.kernel.org>; Sat, 24 Jan 2009 06:21:15 -0800 (PST)
In-Reply-To: <20090120164314.07AD3400E137@mail.nwl.cc>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, florian@openwrt.org


Hi,

On Tuesday 20 January 2009, Phil Sutter wrote:
> 
> Hi,
> 
> I did some review of pata-rb532-cf in order to simplify the code a bit
> in which I think have succeeded.
> 
> After finding the first patch by accident, patches two and three were
> quite obvious. Patch four also solves the discussed changes to
> rb532_pata_data_xfer() as it drops it completely, replacing it by
> a standard libata function. Patch 5 is rather experimental and hopefully
> triggers a discussion about the changes it introduces.

FWIW patches 1-4 look OK to me.

Thanks,
Bart
