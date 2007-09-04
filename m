From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [Bugme-new] [Bug 8976] New: Regression (ata_piix): Kernel panic
 during driver initialization
Date: Tue, 4 Sep 2007 10:02:47 +0200
Message-ID: <18141.4391.263558.343828@alkaid.it.uu.se>
References: <bug-8976-10286@http.bugzilla.kernel.org/>
	<20070903154838.1c0f239a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48300 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXIDIC6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 04:02:58 -0400
In-Reply-To: <20070903154838.1c0f239a.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-ide@vger.kernel.org

Andrew Morton writes:
 > > On Mon,  3 Sep 2007 13:40:10 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
 > >
 > > http://bugzilla.kernel.org/show_bug.cgi?id=8976
 > 
 > This one is apparantly a post-2.6.22 regression.

The ata_piix oops at init bug in 2.6.23-rc5 has already been fixed.
There's a link to the patch at the bugzilla entry quoted above.
