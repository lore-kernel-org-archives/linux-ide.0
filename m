From: "Stuart D. Gathman" <stuart@bmsi.com>
Subject: Re: ide-tape.c (vs. st.c / ide-scsi.c)
Date: Sun, 28 Sep 2003 21:30:51 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0309282123250.17331-100000@bmsred.bmsi.com>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A1F@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.bmsi.com ([66.160.67.186]:2471 "EHLO spidey.bmsi.com")
	by vger.kernel.org with ESMTP id S262771AbTI2Baw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2003 21:30:52 -0400
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A1F@ausx2kmpc106.aus.amer.dell.com>
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: linux-ide@vger.kernel.org, linux-tape@vger.kernel.org

On Fri, 26 Sep 2003 Stuart_Hayes@Dell.com wrote:

> Does using ide-tape have any advantages over using st.c / ide-scsi for
> controlling ATAPI tape drives, other than the following?

For me, ide-tape was easier to set up for all IDE systems (typical low end).
I had to stop using it with kernel-2.4.20 because it simply doesn't
work at all anymore (crashes system).  Setting up for ide-scsi tape
adds several more steps to an install (including append="hdd=ide-scsi" for the
boot loader).

Furthermore, the ide-scsi+st driver prints all kinds of errors on the console
about commands not being recognized when using a low end IDE tape, but the tape
works fine.  Not having looked at the guts of the code, I suspect that ide-tape
knows more about which commands low end IDE drives don't support.

So there is a lot of overlap between ide-scsi+st and ide-tape, but ide-tape
specializes in low end drives - and doesn't expect full SCSI tape compliance.

-- 
			Stuart D. Gathman <stuart@bmsi.com>
      Business Management Systems Inc.  Phone: 703 591-0911 Fax: 703 591-6154
	"[Microsoft] products are even less buggy than others, in terms of
	    per capita usage." - Steve Balmer, Microsoft Corporation

