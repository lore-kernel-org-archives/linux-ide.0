From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Update: Serial ATA support question
Date: Fri, 02 Apr 2004 19:48:53 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406DA785.2000208@stesmi.com>
References: <200403291444.35962.pat@computer-refuge.org> <200404021002.18869.pat@computer-refuge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:11998 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S264135AbUDBRtK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Apr 2004 12:49:10 -0500
In-Reply-To: <200404021002.18869.pat@computer-refuge.org>
List-Id: linux-ide@vger.kernel.org
To: Patrick Finnegan <pat@computer-refuge.org>
Cc: linux-ide@vger.kernel.org

Hi Patrick.

> So, I've got no response, is there a better place to ask this?
> 
> On Monday 29 March 2004 14:44, Patrick Finnegan wrote:
> 
>>So, I'm considering getting some SATA gear to use in a data storage
>>project.  What exactly is the state of hotplug support?  I'm
>>considering a Highpoint Tech Rocket 1540 (HPT374 chipset), and it
>>claims to support Linux as an OS, but I haven't seen anything on
>>mailing lists about use with linux, especially hotswap support.
>>
>>So, is it possible to hotswap these drives, and have the
>>controller/driver detect the new drive?

Search the archives.

The 1540 isn't really a SATA controller, it's got (as you state
yourself) a HPT374 PATA controller and (I believe) a Marvel
PATA<->SATA bridge, hence it's not truly a SATA controller
and I can't remember if you can hotswap with it but I somehow doubt it.

There was a document released a while back by Jeff Garzik (I believe)
that outlines all drivers and what they supported. Search for that
in the archives and you'll see.

Sometimes when people don't answer it's because they already answered it
before or it's easily finadable in the archives.

// Stefan
