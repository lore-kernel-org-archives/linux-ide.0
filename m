From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: sata suspend status?
Date: Sun, 27 Nov 2005 20:56:13 -0800
Message-ID: <20051127205613.18f48772.rdunlap@xenotime.net>
References: <1133020582.438885a6615dc@www.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:1723 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751140AbVK1Ezn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Nov 2005 23:55:43 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 27 Nov 2005 20:55:42 -0800
In-Reply-To: <1133020582.438885a6615dc@www.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Ijichi <dom@ijichi.org>
Cc: linux-ide@vger.kernel.org

On Sat, 26 Nov 2005 15:56:22 +0000 Dominic Ijichi wrote:

> hello
> 
> i've been trying to get my laptop s3 suspend working - its all working except I
> believe for sata.  it resumes and you can do type in, interact with the kernel
> but as soon as you do anything that requires disk access it hangs. sorry if this
> isn't very technical description, i can provide anything if told roughly what to do!
> 
> i've searched extensively for patches, tried all the various incantations, and
> currently running 2.6.15-rc2 which is supposed to provide support for ata
> passthrough and basic scsi suspend, but still same problem. i have:
> 
> Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04)
> 
> /dev/sda = HITACHI_DK23FA-60
> 
> hdparm -I /dev/sda works fine.
> 
> I note recent patches from randy dunlap from intel to do with this controller
> and acpi but not sure what kernel this is against or whether it's relevent.
> 
> i believe there are many people out there who would love to get sata
> suspend/resume working, its a major problem for all recent laptops and us folks
> who love running linux.  what's the current status please?

Hi,
It seems to work for some people.  I don't know if that's just
good luck or that some controllers don't need the SATA ACPI methods
that I am working on.  We should know more about that in the next
few weeks, I hope.

---
~Randy
