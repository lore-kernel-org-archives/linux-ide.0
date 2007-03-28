From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Wed, 28 Mar 2007 10:57:54 +0100
Message-ID: <20070328105754.72b578bd@the-village.bc.nu>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070328000851.GA25551@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47748 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933662AbXC1JLr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 05:11:47 -0400
In-Reply-To: <20070328000851.GA25551@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Wed, 28 Mar 2007 01:08:52 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Fri, Mar 23, 2007 at 07:13:21PM +0000, Alan Cox wrote:
> > For reference this is what I am currently using with 2.6.21-rc4-mm1 and
> > it is working for all my test cases so far: Its basically Kyle's patch
> > with a libata switch to turn it on/off and some minor fixups from
> > the original patch as posted
> 
> Fails for me on a Macbook Pro with:

Ok thanks. This is interesting as the only thing new it is doing is
asking for the HPA size. Does I think explain the problem however: Can
you move the HPA setting call to after the mode has been set and see if
that makes the problem vanish ?
