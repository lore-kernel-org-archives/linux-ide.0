From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Thu, 4 Oct 2007 07:21:58 -0600
Message-ID: <20071004132158.GL12049@parisc-linux.org>
References: <20070906210505.GF27404@parisc-linux.org> <47025887.2090006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57976 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbXJDNWB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 09:22:01 -0400
Content-Disposition: inline
In-Reply-To: <47025887.2090006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, Oct 02, 2007 at 10:41:11AM -0400, Jeff Garzik wrote:
> Did you look at SATA alone?

No.  I don't think I have any pure-SATA machines.  I suppose I could
disable the drivers for non-SATA and see what happens.

> Since SATA does its own scan asynchronously from SCSI itself, doing this 
> seems of little value.  This patch doesn't change AHCI scanning at all, 
> for example.

Its current value lies in allowing SCSI and SATA scans to take place
simultaneously; otherwise SATA forces SCSI to finish its scans before it
starts.  It also allows the SATA asynchronous scan code to become
synchronous.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
