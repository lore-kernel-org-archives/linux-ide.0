From: Aric Cyr <Aric.Cyr@gmail.com>
Subject: Re: [RFC] libata feature list
Date: Thu, 15 Dec 2005 08:48:13 +0000 (UTC)
Message-ID: <loom.20051215T093804-884@post.gmane.org>
References: <43A10FED.4060808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38563 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965173AbVLOIv0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2005 03:51:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Emonw-00069l-HA
	for linux-ide@vger.kernel.org; Thu, 15 Dec 2005 09:49:37 +0100
Received: from epsonfw.epson.co.jp ([203.179.21.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2005 09:49:36 +0100
Received: from Aric.Cyr by epsonfw.epson.co.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2005 09:49:36 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik <at> pobox.com> writes:

> 
> 
> I wrote a quick libata feature list, for people who like that sort of 
> thing.  Before I send it out to linux-kernel and to others, I thought I 
> would run it by linux-ide:
> 
> 	http://linux.yyz.us/sata/features.html
> 
> Comments welcome.
> 
> 	Jeff

Hi Jeff,

Great summary.  Just a few nit-picks :)

1) Title is kind of misleading now that PATA is included.  Not too important,
but PATA will likely get better tested if users know off the bat that it is
(experimentally) supported.

2) I think "Not Supported" should list all the PCI IDE (PATA) controllers that
exist in the mainline kernel but not in libata (e.g. ALi, I think).  This would
make it easier for users to know whether they should bother with PATA support or
not.

Regards,
  Aric

