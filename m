From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unable to use cdrom/dvd drive after some usage
Date: Tue, 15 Jan 2008 11:34:06 +0000
Message-ID: <20080115113406.10d691e3@lxorguk.ukuu.org.uk>
References: <20080115044608.GA13420@www>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43121 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750757AbYAOLgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 06:36:52 -0500
In-Reply-To: <20080115044608.GA13420@www>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johnny Luong <johnny.linux-ide@compfazed.com>
Cc: linux-ide@vger.kernel.org

On Mon, 14 Jan 2008 20:46:08 -0800
Johnny Luong <johnny.linux-ide@compfazed.com> wrote:

> Hi,
> 
> If possible, I would like to know if its worthwhile simply just to get another
> SATA drive / different controller / cable rather than trying to figure out
> this PATA drive on SATA/PATA controller...  see attached for bug report and
> config file.  I'm not on this email list so if you can CC that would be 
> appreciated.

I don't think so. Wine seems to have fed the drive a command that upset
it to the point it needed power cycling. That may also however be a
drive/controller that don't know how to clear data stuck after a wrong
transfer length from an application. In that case 2.6.24-rc6 (or 2.6.24
once out) may actually fix the problem.

If it doesn't then we need to look at it further and find out what is
going on to crash the drive.

Alan
