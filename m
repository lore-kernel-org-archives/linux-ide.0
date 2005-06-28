From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: libata and hotplug status
Date: Tue, 28 Jun 2005 14:55:30 -0600
Message-ID: <4789af9e050628135547fa5e14@mail.gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:48024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261634AbVF1U4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2005 16:56:00 -0400
Received: by zproxy.gmail.com with SMTP id i11so395491nzi
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2005 13:55:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

I read at http://linux.yyz.us/sata/software-status.html that "libata
does not support hotplug... yet", implying that it eventually would.

I am very interested in the current state and progress of SATA hotplug
support for libata-based drivers (specifically the 'sata_promise'
driver for the Promise TX4 card).  Has there been any preliminary work
or discussion on this feature?

How would it best be implemented?  How much of a pain would it be to
do?  Are there any half-baked patches out there I can take a peek at
or help with?  Who can I prod to bump this up on the priority list for
libata?  What should I prod with?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
