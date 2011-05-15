From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata: ahci_start_engine compliant to AHCI spec"
Date: Sun, 15 May 2011 11:25:19 +0200
Message-ID: <201105151125.19614.rjw@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <20110514102804.GB23665@htj.dyndns.org> <BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52493 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab1EOJYm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 May 2011 05:24:42 -0400
In-Reply-To: <BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, Michael Leun <lkml20100708@newton.leun.net>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Sunday, May 15, 2011, Jian Peng wrote:
> Hi, Michael/Rafael/Gu,
> 
> Could you help me understand the testing environme? I like to reproduce it
> if it is possible and debug it. The host controller this patch dealing with
> is not used on PC so my testing environment is quite different.

Well, the system I can reproduce it on is a production one, so I can't
really test too much on it.  What exactly would you like to do?

Rafael
