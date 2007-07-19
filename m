From: Greg KH <gregkh@suse.de>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 09:26:25 -0700
Message-ID: <20070719162625.GA16505@suse.de>
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <469F92AF.10405@googlemail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>, Doug Chapman <doug.chapman@hp.com>, Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>, Jean Delvare <khali@linux-fr.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 19, 2007 at 06:34:55PM +0200, Michal Piotrowski wrote:
> SYSFS
> 
> Subject         : sysfs root link count broken in 2.6.22-git5
> References      : http://lkml.org/lkml/2007/7/15/62
> Last known good : ?
> Submitter       : Jean Delvare <khali@linux-fr.org>
> Caused-By       : ?
> Handled-By      : Tejun Heo <htejun@gmail.com>
> Status          : unknown

This is now fixed in Linus's tree with a patch from Tejun.

thanks,

greg k-h
