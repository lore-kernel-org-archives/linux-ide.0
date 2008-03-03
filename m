From: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: locking problem in sata_sil24?
Date: Mon, 3 Mar 2008 16:44:41 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com> <1204583866.21545.31.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:30726 "EHLO
	mail.innovsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753557AbYCCWoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 17:44:44 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1204583866.21545.31.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
>> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel,

> What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
> the lockdep patches, I need to do more work on them.

Should be an 603e
adn revision (from u-boot)
CPU:   MPC8280 (HiP7 Rev 14, Mask 1.0 1K49M) at 447.897 MHz



I am currently compiling a LOCKDEP kernel for my x86 desktop, as it has
the exact same SiliconImage controller on a card, so I'll see if it gets
a similar detection.
