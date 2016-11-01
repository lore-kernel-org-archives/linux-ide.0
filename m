From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Write performance 50% compared to Windows
Date: Tue, 1 Nov 2016 11:03:23 -0200
Message-ID: <nva41q$404$1@blaine.gmane.org>
References: <adf65b5b8edfe0c1c99bc55a2827a68d@mail.vulnscan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:35588 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1034039AbcKANIP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2016 09:08:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <lnx-linux-ide@m.gmane.org>)
        id 1c1Ymt-0003tx-NP
        for linux-ide@vger.kernel.org; Tue, 01 Nov 2016 14:07:35 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, 01 Nov 2016 11:37:42 +0100
Bram Matthys <syzop@vulnscan.org> wrote:

> I have a Samsung SSD 850 EVO 4TB and under Linux I'm only getting 
> ~240MB/s write speed. On Windows it's 490MB/s (yes, without cache).
> The read speed is the same on both Linux and Windows, though. Both are 
> 512MB/s.

	Just curious: are you using the "deadline" scheduler? What file
system? Ext4?

-- 
https://exchangewar.info


