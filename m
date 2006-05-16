From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 21:33:02 -0700
Message-ID: <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
	 <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
	 <44694C4F.3000008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:53694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751259AbWEPEdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 00:33:03 -0400
Received: by nf-out-0910.google.com with SMTP id k27so41162nfc
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 21:33:02 -0700 (PDT)
In-Reply-To: <44694C4F.3000008@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:


> Can you configure your interrupts so that ethernet and SATA are not on
> the same irq?

Sorry, need a little hand holding here. I'm unsure how to do such a
thing, and can't really google that.

> Also, please provide _full_ dmesg and _full_ lspci, not just the
> SATA-related stuff.  This looks motherboard- or hardware-related.

kern.log is my last 24 hrs, contains everything that came into the kern.log
http://olricha.homelinux.net:8080/dump/kern.log
http://olricha.homelinux.net:8080/dump/lspci-vvv

If there's anything else I can do please let me know
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
