From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add additional queued command opcodes from SATA
 spec
Date: Mon, 22 Jul 2013 16:45:10 -0400
Message-ID: <20130722204510.GC13040@mtj.dyndns.org>
References: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com>
 <20130722200014.GA4042@mtj.dyndns.org>
 <7D07DE2D-D421-4E79-AB4B-27566DCB3655@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:36416 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3GVUpP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 16:45:15 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so4094561qeb.30
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 13:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7D07DE2D-D421-4E79-AB4B-27566DCB3655@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jul 22, 2013 at 01:42:42PM -0700, Marc C wrote:
> I have some out-of-tree user apps that exploit those opcodes
> (via uapi). I eventually will have additional patches, but cannot 

Hmmm?  I don't think ata.h is visible to userland, is it?

> submit the pull request for them until the SATA 3.2 spec is public.

Let's add the opcodes when it becomes actually used in the kernel then
unless it's gonna be a PITA on your end.

Thanks!

-- 
tejun
