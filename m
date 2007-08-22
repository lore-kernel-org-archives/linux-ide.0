From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 22 Aug 2007 16:02:26 +0900
Message-ID: <46CBDF82.6020206@gmail.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com> <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com> <98147300-A282-4909-A393-079365833BD8@infogears.com> <46CBA78D.2070405@gmail.com> <F3FDFA8B-A2EF-4EEE-ACE2-E67776650CF4@infogears.com> <46CBCD18.7070507@gmail.com> <B209C20A-580B-4AD6-A6A0-B4377499B8FC@infogears.com> <46CBDA17.6010009@gmail.com> <D2865984-EF5E-400F-9B71-1F95363D4C3F@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:46886 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbXHVHCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 03:02:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so74397rvb
        for <linux-ide@vger.kernel.org>; Wed, 22 Aug 2007 00:02:31 -0700 (PDT)
In-Reply-To: <D2865984-EF5E-400F-9B71-1F95363D4C3F@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

Rusty Conover wrote:
> After adding a semicolon to the added line, and recompiling there are
> still timeouts like before on the PMP ports.

Oops.

> It did have the effect of setting the SATA speed to 1.5 rather then 3.0
> on boot though.

Yeah, that was the intention.  I'm running out of ideas.  Just some
random suggestions...

* if you have access to different types of disks, try them.

* if you can open the storage box, take out the PMP and connect it and
the harddrive to a different power supply and see whether that changes
anything.

-- 
tejun
