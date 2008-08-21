From: Tejun Heo <teheo@novell.com>
Subject: Re: Initio 1623 driver question
Date: Thu, 21 Aug 2008 11:50:22 +0900
Message-ID: <48ACD7EE.7080605@novell.com>
References: <48AB0F54.5080900@gmail.com> <48AB9B98.6000105@novell.com> <8ce0925c0808201332u604ce2a6sf2274d4517edf95b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52377 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbYHUCu7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 22:50:59 -0400
In-Reply-To: <8ce0925c0808201332u604ce2a6sf2274d4517edf95b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthieu Helder <matthieu.helder@gmail.com>
Cc: linux-ide@vger.kernel.org

Matthieu Helder wrote:
> The calls to ata_link_print() didn't contain the warning level. I've
> added KERN_WARNING.

Eh... Sorry, I build tested it but my eyes just flew over the warning
messages, it seems.

> Could you please provide me with a way to build just the needed
> modules? From a.o. the Linux Kernel Module Programming Guide I don't
> succeed in building just the two kernel modules. The system builds all
> configured modules, which takes rather a long time.
> 
> As soon as I have the requested log, I'll mail it to you. I assume I
> have to look in /var/log/messages for it?

Well, once you rolled your own kernel, keep the build tree with you and
apply the patch on top of it and run make.  It will build only what has
changed.  If you wiped out the original build tree, copy the original
.config file and run "make drivers/ata/libata.ko
drivers/ata/sata_inic162x.ko".  If it doesn't work, run make and let it
go through initial stages of building (maybe a few tens of secs) and
retry the module building.  It usually does the trick.

-- 
tejun
