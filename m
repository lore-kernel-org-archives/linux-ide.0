From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Thu, 3 Feb 2005 13:58:16 +0100
Message-ID: <200502031358.16827.roffermanns@sysgo.com>
References: <200502011257.40059.brade@informatik.uni-muenchen.de> <pan.2005.02.01.20.21.46.334334@surrey.ac.uk> <1107299901.5624.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.8.134.5] ([62.8.134.5]:8607 "EHLO mailgate2.sysgo.com")
	by vger.kernel.org with ESMTP id S262900AbVBCM6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 07:58:19 -0500
In-Reply-To: <1107299901.5624.28.camel@gaston>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Wednesday 02 February 2005 00:18, you wrote:

>
> The IDE layer waits up to 30 seconds for a device to drop it's busy bit,
> which is necessary for some drives that aren't fully initialized yet.
>
> I suspect in your case, it's reading "ff", which indicates either that
> there is no hardware where the kernel tries to probe, or that there is
> bogus IDE interfaces which don't properly have the D7 line pulled low so
> that BUSY appears not set in absence of a drive.
>
I have the same kind of bogus hardware here. What would be the right place to 
workaround this? (unfortunately it's not possible to fix/change the 
hardware).

-Rolf
-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com

