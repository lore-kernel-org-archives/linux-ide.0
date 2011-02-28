From: Tejun Heo <tj@kernel.org>
Subject: Re: Intel ICH9M bug : sata unusable with usbserial
Date: Mon, 28 Feb 2011 16:16:18 +0100
Message-ID: <20110228151618.GA16322@htj.dyndns.org>
References: <20110228140149.GA18189@frolo.macqel>
 <20110228150553.66d02bc7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54096 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab1B1PQX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2011 10:16:23 -0500
Received: by bwz15 with SMTP id 15so3724879bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2011 07:16:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110228150553.66d02bc7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Philippe De Muyter <phdm@macqel.be>, linux-ide@vger.kernel.org

On Mon, Feb 28, 2011 at 03:05:53PM +0000, Alan Cox wrote:
> > The running running processes keep running, and the GPS listening process
> > continues to get messages from the USB GPS receiver each second.
> > 
> > Is that a known (an fixed) problem ?
> 
> No and I doubt it is a general problem or it would have been reported
> long ago. Looks like your hard drive just dropped offline - power
> problems perhaps ?

Looks more like a irq problem to me.  Maybe the USB device causes
screaming IRQ and SATA controller is sharing IRQ with the USB host?
Phillippe, can you please post the output 'cat /proc/interrupts' and
full output of dmesg after the failure?

Thanks.

-- 
tejun
