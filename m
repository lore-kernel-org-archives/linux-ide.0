From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: Small help or advice please....
Date: Sat, 22 Jan 2005 16:30:08 -0800
Message-ID: <20050123003008.GD558606@sgi.com>
References: <Pine.LNX.4.21.0501221445030.16827-100000@ernie.virtualdave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:11912 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261165AbVAWAaX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jan 2005 19:30:23 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0501221445030.16827-100000@ernie.virtualdave.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Sims <dpsims@virtualdave.com>
Cc: jeremy@classic.engr.sgi.com, linux-ide@vger.kernel.org

On Sat, Jan 22, 2005 at 02:49:08PM -0600, David Sims wrote:
> Hi,
> 
>   I am struggling a bit to get a Dell Powervault 745N (i.e., Intel
> 31244/Vitesse 71714 (aka 7174) SATA controller) to run Linux.... I am
> using Slackware with the 3.4.29 kernel.... the only module loaded is the
> ethernet (e1000) and when I try to load sata_vsc it just hangs trying to
> talk to disk 0.... If I unplug all the disks then the module will load and
> all seems well, but without any disks, what's the point? ;)
> 
> 
>   I have temporarly added a pci-ide controller in the expansion slot of
> this box and have Linux running fine via that from a WD-800 pata
> disk... So I have lots of tools, I just don't know how to troubleshoot
> this SATA problem.....
> 
>   Any clues for me?? How can I troubleshoot this problem or get the intel
> 31244 to work??

There's not a lot to go on here.  It's a PCI-X controller, but it uses a
32 bit DMA mask, due to having a fixed upper 32 bits.  I don't know if that
would cause you a problem or not.

Also, the driver was originally developed for the Vitesse 7174 part.  I
have heard of other problems with the Intel part (you'll see them if you
search the archives).  I don't recall hearing whether anyone found the
root cause.  They're supposed to be identical, but . . . .

jeremy
