From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: PMP and SEMB messages to SEP
Date: Fri, 14 Jan 2011 18:37:59 +0100
Message-ID: <20110114173759.GI16039@MAIL.13thfloor.at>
References: <20110113192558.GE16039@MAIL.13thfloor.at> <20110114142018.GA978@htj.dyndns.org> <20110114165957.GH16039@MAIL.13thfloor.at> <20110114170407.GE978@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:40087 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758014Ab1ANRiA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 12:38:00 -0500
Content-Disposition: inline
In-Reply-To: <20110114170407.GE978@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, Jan 14, 2011 at 06:04:07PM +0100, Tejun Heo wrote:
> Hello,

> On Fri, Jan 14, 2011 at 05:59:57PM +0100, Herbert Poetzl wrote:
> > > Unfortunately, it hasn't been implemented yet.  

> > Okay, so any ideas/suggestions how to implement it?

> I'll be happy to answer questions / review patches but I don't
> really have much idea how it should be implemented at this point. 
> I guess libata would just serve as transport layer for the 
> enclosure management high level driver (there were two variants, 
> IIRC). 

Fair enough, let's start with a bunch of simple questions
I got from looking at the code (which I did just recently,
so don't expect deep understanding of the inner workings,
or even intelligent questions FWIW :)

- libata is used in the kernel for ata, sata and to some
  extend for scsi (via (s)ata), as a helper library.
  is there any counterpart in userspace to communicate
  with (s)ata host/devices or how are the interfaces to
  userspace designed to work?

- the SiI3726 supports SAF-TE and SES protocols for the
  SEMB/SEP and the EMCs are sent through the SATA interface
  (according to the docu, SEP_ATTN in the command register
  and SEP command code in the features register)

  + how would I send such a command and retrieve the result
    (if there is one) from within the kernel (maybe with
    libata or from the ahci layer)?

- the SiI3726 supports GPIO pins, which can be reached via
  the General Status and Control Register [130] and accoring
  to the docu, the Read/Write Port Multiplier command can
  be used to read/write that register.
 
  + how would I go about issuing such a command and where
    should it be done? i.e. what about interference with
    other commands? what about retrieving return values?

> There also was something added to ahci which is exported through
> sysfs.

I saw that the ahci driver uses *em_message* which I
think might be related to sending activity messages and
it also lists capabilities (which include 'ems') on
host adapters, but I'm not entirely sure this is SEMB
related (yet)

thanks for your help,
Herbert

> Good luck!
> 
> -- 
> tejun
