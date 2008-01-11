From: Jeff Garzik <jeff@garzik.org>
Subject: Re: LIBATA SCSI command validation changed in 2.6.24
Date: Fri, 11 Jan 2008 16:35:16 -0500
Message-ID: <4787E114.2030301@garzik.org>
References: <4787DFE2.2000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55875 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759387AbYAKVfT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jan 2008 16:35:19 -0500
In-Reply-To: <4787DFE2.2000504@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> commit 607126c2a21cd6e9bb807fdd415c1a992f7b9009 changed command validation
> to allow short commands in 16-byte CDBs, but it also made checking more
> strict. Before the change, a 10-byte SG_IO command could have its length set
> to 9 and still work. Now it fails. Not sure if this is a bug, but it has
> caused at least one application to fail that used to work (qpxtool.)
> 
> [https://bugzilla.redhat.com/show_bug.cgi?id=428281]

Can you get us an example CDB?  Its unclear if the hexdump in the bug 
report is a returned mode page or the CDB or what...?

	Jeff




