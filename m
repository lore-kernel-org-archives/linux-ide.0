From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Status of the sata_sil driver for the VT8237
Date: Sun, 28 Mar 2004 09:37:15 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406680AB.8090204@stesmi.com>
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:44211 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262108AbUC1Hh0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 02:37:26 -0500
In-Reply-To: <40664AE4.8010003@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi.

> I meant sata_via, I dunno why I said sata_sil; Freudian typo.  I was 
> thinking of the current sii3112 I use, which has been stable and 
> blazingly fast for awhile with the IDE driver--and a little little patch 
> I keep applying.  I'm looking to upgrade a server with 2 Raptors in it 
> to an A64 running 64-bit Linux of course.  I wanna get the HDs off the 
> PCI bus and onto the VT8237 southbridge.  I was wondering if the driver 
> for -that southbridge- was still considered beta.

Many A64 boards today come with a Promise SATA controller as well -
works like a charm for me on an ASUS K8V Deluxe board here.

The driver is sata_promise but I guess you either knew that or
would be able to figure it out yourself :)

// Stefan
