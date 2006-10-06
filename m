From: "Steve Hindle" <mech422@gmail.com>
Subject: Re: PROBLEM: Hardlock with 2.6.18-mm3 on Abit AI7, ICH5 + EXT3/XFS, SATA under heavy I/O load
Date: Thu, 5 Oct 2006 20:04:56 -0700
Message-ID: <9a0545880610052004o78433b52u24154e8ba1080bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:6497 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWJFDE6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Oct 2006 23:04:58 -0400
Received: by nf-out-0910.google.com with SMTP id o25so970096nfa
        for <linux-ide@vger.kernel.org>; Thu, 05 Oct 2006 20:04:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

I confirmed I get the exact same behavior with 2.6.18-mm3 and ext3..
So I don't think XFS is the problem.

Its _really_ annoying that the box is more stable under windows then
linux :-(  Is there anything I can do to help narrow it down?  The
configs are the same as in the previous post, except this time I
booted with 2.6.18-mm3.  I suspect a SATA problem, but I'm unsure what
to test?  should I try booting with acpi=off? or maybe disabling
(l?)apic stuff?  I don't have any idea what boot options are
relavent...Given it only flakes under 'heavy' load, could it be
interrupt related?

Steve
