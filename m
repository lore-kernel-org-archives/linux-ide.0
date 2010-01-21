From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 16:08:36 -0500
Message-ID: <c9b548c76ace3c52752bec43ffe7127a.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <fbae475f602d8f79f27d2d36be0de4f7.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:3610 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755200Ab0AUVIi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 16:08:38 -0500
Received: from d72-38-7-254.commercial1.cgocable.net
	([72.38.7.254] helo=thechecks.ca ident=gaeogfo)
	by max with esmtp (Exim 4.71)
	(envelope-from <paul@thechecks.ca>)
	id 1NY4Ga-0006CD-GT
	for linux-ide@vger.kernel.org; Thu, 21 Jan 2010 16:08:36 -0500
In-Reply-To: <fbae475f602d8f79f27d2d36be0de4f7.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

With pata disabled, the ata assignments still move around, so this was
unrelated.  I will report back if I still get the link down after 20
boots.  P

> Now, with pata_marvell NOT compiled into the kernel, on the first try I am
> getting the hard drives on ata1.00, ata1.01, ata2.00 and ata2.01, and the
> Sony BWU on sata3, which seems "correct" given the ports I have the drives
> plugged into.


