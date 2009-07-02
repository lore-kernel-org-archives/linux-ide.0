From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about LS120 floppies
Date: Thu, 2 Jul 2009 18:12:40 +0100
Message-ID: <20090702181240.747e4063@lxorguk.ukuu.org.uk>
References: <4A4BC762.3090104@lwfinger.net>
	<4A4C441B.6050808@gmail.com>
	<4A4CBD9E.4070404@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44306 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751754AbZGBRLH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 13:11:07 -0400
In-Reply-To: <4A4CBD9E.4070404@lwfinger.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Thu, 02 Jul 2009 09:01:02 -0500
Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Robert Hancock wrote:
> > On 07/01/2009 02:30 PM, Larry Finger wrote:
> >> I have been trying to help someone on the openSUSE forums. He is
> >> running a 2.6.27 kernel and finds that his "Super Floppy" drive works
> > 
> > Are they using the old IDE drivers, or libata? Do they have any kernel
> > output, etc?
> 
> In 2.6.27, I think he has the old IDE driver, but I'm not sure. In any
> case, the entire thread on the openSUSE forum is at
> 
> http://forums.opensuse.org/hardware/417147-ls-120-opensuse-11-a.html
> 
> Thanks for any help you can give.

Basically four content free pages. Ignoring all the stuff about HAL the
hardware is detected and the drive reports that the media type is not
supported.

That all appears to be working beautifully, although I've no idea why the
media type is not supported - I wonder if something is trying to read the
wrong block sizes or if the LS120 has some magic no standard bits.

Unfortunately they are very very obscure hardware.

Alan
