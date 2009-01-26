From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Mon, 26 Jan 2009 17:02:11 -0500
Message-ID: <20090126220210.GB26064@csclub.uwaterloo.ca>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan> <20090125110742.4ba54c0b@lxorguk.ukuu.org.uk> <alpine.DEB.1.10.0901250705300.6888@p34.internal.lan> <alpine.DEB.1.10.0901250715030.10379@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753123AbZAZWC3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901250715030.10379@p34.internal.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xfs@oss.sgi.com
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 25, 2009 at 07:15:40AM -0500, Justin Piszcz wrote:
> It comes with one :)
> # xfs_admin -u  /dev/sdd2
> UUID = 77ae4251-631f-4656-a365-c5723f5c5da8
> 
> Will try to use this to boot; however, I'd prefer the labels over the 
> UUID, wish there was an easy way to set it.

I prefer UUIDs.

Much mroe likely to have the same label on multiple drives than the same
UUID.  I don't want to have to worry about what label some usb device
might have if I happen to have it plugged in during a reboot.

Labels do tend to be shorter and more human readable of though.

-- 
Len Sorensen
