From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA II generation controllers reset problem
Date: Thu, 19 Feb 2009 18:19:44 +0900
Message-ID: <499D2430.3080601@kernel.org>
References: <4993C535.10204@very-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55490 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757363AbZBSJUL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 04:20:11 -0500
In-Reply-To: <4993C535.10204@very-soft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Krivopalov <argenet@very-soft.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Vladmir.

Vladimir Krivopalov wrote:
> Greetings, Jeff!
> 
> My name is Vladimir Krivopalov, and I work as software developer in
> VerySoft LLC, Russia.
> We currently develop a project containing Linux and Windows client-side
> parts and have to implement 'hot reboot' from Linux to Windows for our
> purposes. We use kexec application and grub4dos bootloader for this.
> There's a problem we discovered while developing our project in Linux
> part. It occurs when an effort to switch from protected mode to the real
> mode is taken and bootloader is started, but it fails while looking for
> the SATA II drives.
> As for normal booting with grub4dos, it has no probmels with detecting
> SATA drives. It also finds all IDE drives and SATA I (that have
> IDE-compartible interface) normally.
> We suppose the reason could be in that SATA II controllers aren't
> resetted properly. Could you please provide any explanations on how are
> they reset by default in libata library for Linux?

You need to provide more information to get better response but, in
general, that's not gonna work reliably in generic manner unless
whatever is being loaded after linux knows how to reconfigure all the
devices into a state BIOS code expects them to be.

If you confine the problem to ATA controllers, I can think of two
problems from the top of my head.

1. Some modern ATA controllers come with dual programming interfaces
   which can be switched on the fly and when possible linux switches
   them to the native mode to use various features.  BIOSen are coded
   expecting the controller to be in legacy mode, so it won't work.

2. There are BIOSen which can handle native interface.  e.g. sil24 or
   ahci BIOSen.  However, these interfaces require a lot more
   initialization than legacy IDE programming interface.  For legacy
   IDE, once the port addresses are determined, it's all peachy but
   more modern interfaces need their address registers programmed at
   the very least.  Those registers of course won't contain values
   that BIOS expects after such hot reboot.

If you're working on specific hardware, you can probably do specific
initialization stuff during the process and put things as the BIOS
expects them but if you're trying to come up with a general solution,
I'm a bit skeptical it's gonna fly very far.

Thanks.

-- 
tejun
