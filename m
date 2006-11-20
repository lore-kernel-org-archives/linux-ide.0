From: Russell King <rmk+pcmcia@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] pcmcia: Add an id to ide-cs.c
Date: Mon, 20 Nov 2006 21:07:03 +0000
Message-ID: <20061120210702.GD26791@flint.arm.linux.org.uk>
References: <20061119163427.GA2924@dominikbrodowski.de>
	<20061119163851.GB2924@dominikbrodowski.de>
	<20061120095349.GA15410@flint.arm.linux.org.uk>
	<20061120174333.GA18660@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20061120174333.GA18660@isilmar.linta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

On Mon, Nov 20, 2006 at 12:43:33PM -0500, Dominik Brodowski wrote:
> As the matching by func_id is fuzzy and gives false positives, this is a
> multiple-step process:
> 
> a) the kernel checks all built-in and previously loaded modules for
>    prod_id and manf_id matches
> 
> b) userspace (udev/hotplug + modprobe) loads appropriate modules (including
>    those which are only matched by func_id
> 
> c) during the module initialization (e.g. modprobe hasn't returned yet) the
>    kernel checks the modules based on prod_id and manf_id matches
> 
> d) after all these modprobe calls return, userspace writes "1" into
>    /sys/$devpath/allow_func_id_match. Then, the kernel re-checks all
>    built-in and previously loaded modules for func_id "fuzzy" matches.
> 
> It is self-evident that steps b)-d) only work once userspace is ready. As
> PCMCIA drivers should be able to work even before that, manf_id and prod_id
> table entries do make sense even if func_id matching works.

However, it doesn't scale.  You're going to be forever adding entry
after entry after entry to drivers.  It's a never-ending job.

Of course, it's really up to you whether you want this task. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
