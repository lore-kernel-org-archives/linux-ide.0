From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: 26 Dec 2005 14:10:12 +0900
Message-ID: <87wthsqw97.fsf@marrow.phys.tohoku.ac.jp>
References: <871x09nmin.fsf@marrow.phys.tohoku.ac.jp>
	<20051220105514.01815cba.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:25107 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP
	id S1751017AbVLZFKS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Dec 2005 00:10:18 -0500
In-Reply-To: <20051220105514.01815cba.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org

Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:

> On 20 Dec 2005 00:18:24 +0900
> Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:
> 
> > This patch set does not work on my ThinkPad X41 Tablet.  I applied the
> > seven patches to kernel 2.6.15-rc5-git3.  I added "acpi_sleep=s3_bios"
> > to the kernel command line.
> > 
> 
> I've read your mail several times now and don't have any real
> ideas for you, but I wanted to reply so that you wouldn't feel
> like you were being ignored.
> 

I found that ACPI sleep/wakeup works if I (compile and) insert the
snd_intel8x0m module, which I don't need normally.  If I have rmmod-ed
snd_intel8x0m, wakeup fails.  As you said, the message "device is not
power manageable" was not a critical error.

Thanks,

Jae-hyeon
