From: Ted Ts'o <tytso@mit.edu>
Subject: Re: PROBLEM: Disk continually remounts and hardlocks the entire
 system if running on battery.
Date: Wed, 19 Jan 2011 09:59:28 -0500
Message-ID: <20110119145928.GC3043@thunk.org>
References: <AANLkTi=_GSgFpsidp35-RDT3i6zhimXtyR=d6UtFmfMe@mail.gmail.com>
 <87ipxlj1vd.fsf@dmon-lp.sw.ru>
 <4D362DD2.8070606@gmail.com>
 <AANLkTi=ePSM7QTQgouAeP8xwLE0xFr3kW7iuBCqg8Wxb@mail.gmail.com>
 <AANLkTimh01GO1wxOWzYmPsyh0EuTCuxzr6+krNVTjRCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:35682 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124Ab1ASO7k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Jan 2011 09:59:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimh01GO1wxOWzYmPsyh0EuTCuxzr6+krNVTjRCP@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: John Tyree <johntyree@gmail.com>, Dmitry <dmonakhov@openvz.org>, Eric Sandeen <sandeen@redhat.com>, Jiaying Zhang <jiayingz@google.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

On Wed, Jan 19, 2011 at 08:43:03AM -0600, Robert Hancock wrote:
> 
> That doesn't look like the same thing - in their case it doesn't look
> like any SATA errors are occurring, just a remount (presumably
> triggered by some userspace software).

If you have laptop mode, you definitely want to disable it, and see if
that makes a difference.  That being said, if userspace code is able
to trigger errors like that from the hardware, I'd say at first glance
the kernel should do a better job protecting itself from buggy
software, even if it is buggy software running as root....

	       	     	      	       	       - Ted
