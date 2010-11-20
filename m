From: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Subject: Re: ide boot failure 2.6.36/2.6.28 - 2.6.27 works
Date: Sat, 20 Nov 2010 04:28:33 +0100
Message-ID: <20101120032828.GA14693@iq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.cwi.nl ([192.16.191.8]:52742 "EHLO hera.cwi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127Ab0KTD2r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Nov 2010 22:28:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Answering myself (and providing info that can be Googled):

> I wanted to boot a recent kernel on an old machine and failed.
> The last kernel that worked was 2.6.27.
> What goes wrong is that the disks are no longer detected on 2.6.28.

A typical error would be

	Cannot open root device 342 or unknown block (3,66)

Reading the code shows that the default probing is no longer done.
Editing ./drivers/ide/ide-generic.c and changing

-static int probe_mask;
+static int probe_mask = 3;

returns my disks to life, and this old machine boots again.

Andries
