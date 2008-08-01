From: Tejun Heo <tj@kernel.org>
Subject: Re: possible data corruption on ICH8 or WD raptor
Date: Fri, 01 Aug 2008 13:29:07 +0900
Message-ID: <48929113.4020402@kernel.org>
References: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44660 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbYHAE3h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 00:29:37 -0400
In-Reply-To: <0b8b01c8e5fb$65ed9480$0400a8c0@dcccs>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Janos Haar <djani22@netcenter.hu>
Cc: linux-ide@vger.kernel.org

Janos Haar wrote:
> Hello list,
> 
> I have one (planned) production ready server with DP35DP Intel
> motherboard, and 6 drive.
> 
> 2x 500GB WD SATA (not interesting)
> 4x 300GB WD Velociraptor, SATA2
> 
> When i have tested the server i see one error report on the dmesg:
> 
> ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xa frozen
> ata3.00: irq_stat 0x00400040, connection status changed
> ata3: SError: { PHYRdyChg DevExch }
> ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>         res 40/00:20:40:de:90/00:00:07:00:00/40 Emask 0x10 (ATA bus error)

You're getting PHY event on flush which is a pretty strong indication
that you're having power problem.  The disk goes out to transfer data in
its buffer to the platter and draws more power from the cable.  For some
reason, power is not maintained properly.  Disk checks out momentarily
causing the PHY event and losing the data in its buffer.  Try to connect
the harddrive to a separate PSU and see whether the problem goes away.

-- 
tejun
