From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] ata: Fix DVD not dectected at some Haswell platforms
Date: Tue, 5 Mar 2013 11:25:13 +0100
Message-ID: <20130305102513.GA4914@pd.tnic>
References: <1361203255-1670-1-git-send-email-youquan.song@intel.com>
 <20130305142114.GA27413@linux-youquan.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130305142114.GA27413@linux-youquan.bj.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Youquan Song <youquan.song@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, htejun@gmail.com, ming.lei@canonical.com, sshtylyov@mvista.com, lpechacek@suse.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 05, 2013 at 09:21:14AM -0500, Youquan Song wrote:
> Hi Maintainer,
> 
> Can you take the patch which is needed by some new platforms?

I think you've got the wrong guy. Here's how you can find out who the
maintainer is:

So your patch is against drivers/ata/ata_piix.c. So you do:

$ ./scripts/get_maintainer.pl -f drivers/ata/ata_piix.c
Jeff Garzik <jgarzik@pobox.com> (supporter:SERIAL ATA (SATA)...)
linux-ide@vger.kernel.org (open list:SERIAL ATA (SATA)...)
linux-kernel@vger.kernel.org (open list)

And this is the CC list you can use to send the patch to.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
