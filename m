From: Tony Luck <tony.luck@intel.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 17:55:05 -0700
Message-ID: <12c511ca0510291755j3548c61em73d5f9e20e7d1404@mail.gmail.com>
References: <20051029182228.GA14495@havoc.gtf.org>
	 <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com>
	 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
	 <20051029152157.01369c35.akpm@osdl.org>
	 <Pine.LNX.4.64.0510291526040.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:10475 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932706AbVJ3AzF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Oct 2005 20:55:05 -0400
Received: by xproxy.gmail.com with SMTP id t12so680059wxc
        for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 17:55:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0510291526040.3348@g5.osdl.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Perhaps the script that creates the -git1 etc. nightly snapshots
could peek at how many commits were included since the
previous snapshot ... if it is above some threshhold, then it
could run "git bisect" to create a -git0.5 (recursing if needed
to make -git0.25 etc.)

-Tony
