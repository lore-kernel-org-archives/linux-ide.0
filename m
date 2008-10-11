From: gettinther <gettinther@gmail.com>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Sun, 12 Oct 2008 00:34:18 +0100
Message-ID: <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>
References: <48E80F11.3060101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:58698 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbYJKXeU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 19:34:20 -0400
Received: by rn-out-0910.google.com with SMTP id k40so622526rnd.17
        for <linux-ide@vger.kernel.org>; Sat, 11 Oct 2008 16:34:18 -0700 (PDT)
In-Reply-To: <48E80F11.3060101@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

On Sun, Oct 5, 2008 at 1:49 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Please verify whether the attached patch fixes all hardreset / probing
> related issues.  The patch is on top of v2.6.27-rc8.  Sorry about all
> the mess but it was quite a confusing problem.  Here's what went down.
>
> * During 2.6.27-rcX, libata switched to prefer hardreset.
>
> * Which broke, generic flavor of sata_nv.  Some sata_nv's fail to
>  bring the link up after hardreset.
>
> * A fix patch went in to disable hardreset for generic flavor.  But it
>  accidentaly disabled hardreset for all flavors.
>
> * Which broke nf2/3 and CK804, because their hotplug interrupt bits
>  never get cleared.  They're apparently cleared by hardreset
>  sequence.
>
> * Another fix patch went in to reinstate nv_hardreset for nf2/3 and
>  CK804.
>
> * Which broke nf2/3, which was because nf2/3's hardreset was broken in
>  different way.
>
> So, to sum up, each generation of sata_nv controllers exhibits
> different hardreset behaviors.
>
> * generic: doesn't work.
>
> * nf2/3: signature D2H Reg FIS delivery doesn't work.
>
> * ck804: works.
>
> So, all three require different treatments to prefer hardreset and any
> solution which didn't do that was broken.  The attached patch should
> solve all the problems.
>
> It was messy but this at least fixes hardreset for all flavors of nv
> controllers, so it will generally improve reliability.
>
> Thanks.
>
> --
> tejun
>

OK, patching the 2.6.26 based on your patch doesn't work properly.  It
works for sata devices but not sata emulated devices (but these do
work with the 2.6.27).
