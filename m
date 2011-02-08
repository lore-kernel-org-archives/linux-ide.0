From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Tue, 8 Feb 2011 13:25:18 +0000
Message-ID: <20110208132518.300bb098@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51649 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753781Ab1BHNVo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:21:44 -0500
In-Reply-To: <AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> >> We may need to set SITRE before programming slave_data.
> >
> > Do you have a documentation cite for this or is it random fiddling with a
> > driver you can't test ?
> 
> It is good to enable SITRE register before programming it and all
> Intel controllers

That sounds like someone quoting religion. Documentation cite please.
