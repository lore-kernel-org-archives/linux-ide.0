From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.6.30-rc4 kernel
Date: Tue, 19 May 2009 09:44:57 +0200
Message-ID: <20090519074457.GA26155@liondog.tnic>
References: <20090518200558.D61FB567E@p4.dav.net> <20090519055706.GA23611@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:45959 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZESHpB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 03:45:01 -0400
Received: by bwz22 with SMTP id 22so3645622bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 00:45:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519055706.GA23611@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@housetosell.net
Cc: rob@housetosell.net, linux-ide@vger.kernel.org

Hi,

On Tue, May 19, 2009 at 07:57:06AM +0200, Borislav Petkov wrote:
> (adding linux-ide to CC)
> 
> On Mon, May 18, 2009 at 09:05:58PM +0100, rob@housetosell.net wrote:
> > On Wed, May 13, 2009 at 07:17:17PM +0100, rob1@housetosell.net wrote:
> > 
> > Hi
> > 
> > I am not sure how much use this will be however if a break point is set to cdrom_newpc_intr and go is continuosly pressed then the kernel will actually boot (it will also boot if there is no media in the cdrom's) however the cdrom cannot be mounted. The dmesg output and the syslog may provide some useful information:-
> > 
> > from dmesg
> > 
> > ide-cd: hdc: ide_cd_check_ireason: bad interrupt reason 0x03
> > hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > ide: failed opcode was: unknown
> > hdc: drive not ready for command
> > 
> > and from the syslog
> > 
> > May 18 19:30:37 jewel kernel: hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > May 18 19:30:37 jewel kernel: ide: failed opcode was: unknown
> > May 18 19:30:37 jewel kernel: hdc: drive not ready for command
> > May 18 19:30:37 jewel kernel: attempt to access beyond end of device
> > May 18 19:30:37 jewel kernel: hdc: rw=0, want=68, limit=4
> > May 18 19:30:37 jewel kernel: isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
> > 
> > Full versions of dmesg and the syslog are below.

by the way, can you send the dmesg of a kernel with which your hdc drive
works fine?

Thanks.

-- 
Regards/Gruss,
    Boris.
