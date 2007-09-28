From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 07:18:56 -0700
Message-ID: <46FD0D50.8030602@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org> <46FA1B4E.8090103@gmail.com> <46FD079F.3010007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:14290 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760738AbXI1OUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 10:20:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2523878nfb
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 07:20:38 -0700 (PDT)
In-Reply-To: <46FD079F.3010007@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> Is this NACK on the patchset or can we update PMP access later?
> 
> Sorry, yes, it is a NAK:  polling should not be requirement.
> 
> I considered making multi-protocol ->qc_issue() a requirement too, but
> that seemed like it might delay things too much.  But consider this a
> strong to-do item...  ->pmp_read and ->pmp_write hooks should be folded
> into ->qc_issue and ata_qc_complete(), because quite often a PMP
> read/write packet can be delivered just like any other packet.  We want
> a single "submit packet to hardware" interface, not multiple ones.

Aieee... Another merge delay.  I wish the review process proceeded a bit
swifter.   The patchset has been around literally for years now and
submitted for review six times if I have the take number right.  :-(

-- 
tejun
