From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 18:34:55 +0200
Message-ID: <469F92AF.10405__1886.90014551884$1184863019$gmane$org@googlemail.com>
References: <469F9125.8040502@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <469F9125.8040502@googlemail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@suse.de>, Theodore Tso <tytso@mit.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Doug Chapman <doug.chapman@hp.com>, Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-ide@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-git.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            3
Andi Kleen                             2
Andrew Morton                          2
David Woodhouse                        2
Hugh Dickins                           2
Jens Axboe                             2



FS

Subject         : ia64 build failure from recent diskquota patch
References      : http://lkml.org/lkml/2007/7/18/407
Last known good : ?
Submitter       : Doug Chapman <doug.chapman@hp.com>
Caused-By       : Vasily Tarasov <vtaras@openvz.org>
                  commit b716395e2b8e450e294537de0c91476ded2f0395
Handled-By      : ?
Status          : unknown

Subject         : ext4 build warnings
References      : http://lkml.org/lkml/2007/7/18/420
Last known good : ?
Submitter       : Jeff Garzik <jeff@garzik.org>
Caused-By       : ?
Handled-By      : Mingming Cao <cmm@us.ibm.com>
Status          : unknown



IDE

Subject         : compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
References      : http://lkml.org/lkml/2007/7/18/11
Last known good : ?
Submitter       : Kumar Gala <galak@kernel.crashing.org>
Caused-By       : ?
Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Status          : unknown



Memory management

Subject         : kmalloc zero size changes break i386
References      : http://lkml.org/lkml/2007/7/19/172
Last known good : ?
Submitter       : Andi Kleen <ak@suse.de>
Caused-By       : Christoph Lameter <clameter@sgi.com>
                  commit 6cb8f91320d3e720351c21741da795fed580b21b
Handled-By      : ?
Status          : unknown



SYSFS

Subject         : sysfs root link count broken in 2.6.22-git5
References      : http://lkml.org/lkml/2007/7/15/62
Last known good : ?
Submitter       : Jean Delvare <khali@linux-fr.org>
Caused-By       : ?
Handled-By      : Tejun Heo <htejun@gmail.com>
Status          : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
