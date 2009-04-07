From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Mon, 06 Apr 2009 22:59:36 -0400
Message-ID: <49DAC198.1090708@pobox.com>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com> <49D64DE0.8060400@sutus.com> <49D6E90C.5030109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36065 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbZDGDAu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 23:00:50 -0400
In-Reply-To: <49D6E90C.5030109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Dustin Harrison <d.harrison@sutus.com>, Sagar Borikar <sagar.borikar@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Can you please move the logic to sil_freeze() and see whether it
> works?  The freeze handler is supposed to put the controller into idle
> (or at least not-crazy) state, so things like this fit there.

ata_qc_complete() is called before ->freeze(), and ata_qc_complete() 
needs taskfile access to fill the result TF.

I thought about ->pre_freeze(), but now I wonder if we shouldn't just 
call __ata_port_freeze() before ata_port_abort(), in ata_port_freeze()?

	Jeff



