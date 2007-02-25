From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug in cable detection
Date: Sun, 25 Feb 2007 19:50:41 +0100
Message-ID: <200702251950.41867.bzolnier@gmail.com>
References: <20070205080128.GH1625@htj.dyndns.org> <200702251839.36205.bzolnier@gmail.com> <45E1CA42.6070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:17738 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965088AbXBYSo0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 13:44:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so644686uga
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 10:44:24 -0800 (PST)
In-Reply-To: <45E1CA42.6070707@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


On Sunday 25 February 2007, Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Why can't libata do the right thing and just send IDENTIFY command
> > to the slave device first?
> 
> That's my plan B.  I'm just not sure whether it would do any good, would it?

Probably it would but to know for sure you would need to verify it on some
of the affected system (shouldn't be problem given number of the bugreports).

Bart
