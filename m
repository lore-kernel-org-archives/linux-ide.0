From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [git patches] libata updates
Date: Tue, 01 May 2007 18:49:24 -0400
Message-ID: <4637C3F4.5030800@redhat.com>
References: <20070429161542.GA12501@havoc.gtf.org> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us> <200705011438.07499.jesse.barnes@intel.com> <4637C30C.5000109@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795AbXEAWtd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 18:49:33 -0400
In-Reply-To: <4637C30C.5000109@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Jesse Barnes <jesse.barnes@intel.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Stephen Clark wrote:
>>
> I'm running fc6 but with kernel 2.6.21 from kernel.org - compiled with
> the .config file from fc6.
> 
> My system is a asus laptop with an ich7 chipset which has both sata and
> pata controllers. My
> laptop only brings out the pata controller interface and both my hd and
> od are on the second
> channel of the pata.
> 
> So can I configure out the old ide and just have ata_piix automatically
> control them both in
> 2.6.21?
> 

Sure, just edit the .config. You may need to play with options to mkinitrd
though; I don't think it will include the PATA drivers for you automatically.


