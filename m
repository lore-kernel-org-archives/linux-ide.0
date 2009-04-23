From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [2.6.30-rc2] CD-R: wodim intermittent failures: [sr0] Add. Sense: Logical block address out of range, sector 0
Date: Thu, 23 Apr 2009 00:07:13 -0700
Message-ID: <20090423070713.GF19113@hexapodia.org>
References: <20090421015234.GA7014@hexapodia.org> <20090422144904.407df635.akpm@linux-foundation.org> <49F00EBB.7040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752649AbZDWHH2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49F00EBB.7040504@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 23, 2009 at 12:46:19AM -0600, Robert Hancock wrote:
> >Oh well, let's tentatively assume that we have a post-2.6.29 regression
> >in the libata ahci driver.
> 
> I tend to doubt it's a problem in ahci itself, I would guess it's higher 
> up the stack. Or could be that it's not a kernel bug, just some change 
> in timing that triggers the problem.
> 
> What's supposed to stop udev/hal from poking at the drive while wodim is 
> writing to the disc, anyway?

wodim opens O_EXCL, and it does occasionally complain about not being
able to open, then sleeping and retrying.

-andy
