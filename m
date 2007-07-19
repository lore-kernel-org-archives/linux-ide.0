From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 21:27:06 +0200
Message-ID: <200707192127.07238.bzolnier@gmail.com>
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <469F92AF.10405@googlemail.com>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>, Doug Chapman <doug.chapman@hp.com>, Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Thursday 19 July 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject         : compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
> References      : http://lkml.org/lkml/2007/7/18/11
> Last known good : ?
> Submitter       : Kumar Gala <galak@kernel.crashing.org>
> Caused-By       : ?
> Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Status          : unknown

Not a 2.6.22-git regression (CONFIG_BLOCK was added on September 2006) and
Kumar should have a fix really soon - could be removed from the list IMO.

Thanks,
Bart
