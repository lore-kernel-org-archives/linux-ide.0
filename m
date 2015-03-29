From: Simon Bourne <simonbourne+gmane@gmail.com>
Subject: Re: Samsung SSD 850Pro firmware update queued TRIM problems
Date: Sun, 29 Mar 2015 10:00:41 +0000 (UTC)
Message-ID: <loom.20150329T115337-231@post.gmane.org>
References: <54EB35EF.2050103@zahlenfresser.de> <yq1zj8340nj.fsf@sermon.lab.mkp.net> <54ECE94B.9050302@zahlenfresser.de> <yq1twy9k57w.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50286 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbbC2KFH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Mar 2015 06:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1YcA5Y-0002Je-MG
	for linux-ide@vger.kernel.org; Sun, 29 Mar 2015 12:05:04 +0200
Received: from cpc19-flit3-2-0-cust71.9-1.cable.virginm.net ([82.9.65.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2015 12:05:04 +0200
Received: from simonbourne+gmane by cpc19-flit3-2-0-cust71.9-1.cable.virginm.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 29 Mar 2015 12:05:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Martin K. Petersen <martin.petersen <at> oracle.com> writes:

> 
> >>>>> "Stefan" == Stefan Keller <linux-list <at> zahlenfresser.de> writes:
> 
> Stefan> Hello list, I recently updated the firmware on my Samsung 850
> Stefan> Pro from EXM01B6Q to EXM02B6Q.  Now "fstrim -v /" causes SATA
> Stefan> command timeouts related to TRIM with NCQ.
> >> 
> >> Do these timeouts happen if you disable ALPM?
> 
> Stefan> Yes.
> 
> Bummer. The only good data point we have wrt. queued TRIM problems is
> that things only appear to fail when ALPM is enabled. Things are working
> fine for me on all the systems in the lab, however, and I have never
> been able to reproduce any of the issues reported.
> 
> I don't have any 850 drives but will try to get one. For now we should
> blacklist queued trim on those.
> 


Another data point: I have the same problem, but on a 256 pro. Same firmware
(EXM02B6Q from factory), with ALPM disabled.

Regards,

Simon


