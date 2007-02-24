From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: PMP patches for more recent kernel?
Date: Sat, 24 Feb 2007 18:54:13 +0100
Message-ID: <45E07BC5.2050506@drzeus.cx>
References: <45DF92B1.6040001@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:58960 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932427AbXBXRxz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 12:53:55 -0500
In-Reply-To: <45DF92B1.6040001@drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Pierre Ossman wrote:
> Hi,
> 
> I'm eager to test out your PMP patches as I'm currently sitting on a SATA disk
> rack that requires a PMP to be used. Your current set is from october though and
> seems to require some work to get to apply on the current kernel. Do you have
> something newer I can play with?
> 

I've managed to rebase your PMP tree against HEAD and I'm not successfully
running a PMP off a sil24 device. In case you want to use my work, it can be
pulled from kernel.org (branch pmp):

http://www.kernel.org/git/?p=linux/kernel/git/drzeus/mmc.git;a=summary

Be aware that I'm a complete SATA noob though and my rebase consisted of fixing
merge conflicts and compile errors.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
