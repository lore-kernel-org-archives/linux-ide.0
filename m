From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ahci per-port msix support
Date: Tue, 3 Nov 2015 17:32:20 -0500
Message-ID: <20151103223220.GF5749@mtj.duckdns.org>
References: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151102192302.GD9553@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36068 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798AbbKCWcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2015 17:32:23 -0500
Received: by ykba4 with SMTP id a4so41763532ykb.3
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2015 14:32:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151102192302.GD9553@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Mon, Nov 02, 2015 at 02:23:02PM -0500, Tejun Heo wrote:
> On Sun, Nov 01, 2015 at 01:43:35PM -0500, Dan Williams wrote:
> > Changes since v1 [1]:
> > 
> > 1/ Clean up "nvec = min(nvec, n_ports);" statement (Tejun)
> > 
> > 2/ Drop threaded interrupt handling option for now.
> > 
> > [1]: http://marc.info/?l=linux-ide&m=144623970817213&w=2
> 
> Applied to libata/for-4.4.

Dan, I got the following build failures from kbuild and reverted the
two patches from for-4.4.  It's too late for this merge window anyway.
Let's try the next one.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/libata for-4.4
head:   3758b0e5028c4b5083f2148ddc06b719d73e7627
commit: 6cb1c51aa65039ab3860c9741f9a190b7ab199cb [19/20] ahci: per-port msix support
config: mips-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6cb1c51aa65039ab3860c9741f9a190b7ab199cb
        # save the attached .config to linux build tree
        make.cross ARCH=mips

All errors (new ones prefixed by >>):

   drivers/ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
>> drivers/ata/libahci.c:2492:4: error: invalid use of undefined type 'struct msix_entry'
       irq = hpriv->msix[i].vector;
       ^
>> drivers/ata/libahci.c:2492:21: error: dereferencing pointer to incomplete type 'struct msix_entry'
       irq = hpriv->msix[i].vector;
                        ^

vim +2492 drivers/ata/libahci.c

  2486           */
  2487          for (i = 0; i < host->n_ports; i++) {
  2488                  struct ahci_port_priv *pp = host->ports[i]->private_data;
  2489                  int irq;
  2490
  2491                  if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
> 2492                          irq = hpriv->msix[i].vector;
  2493                  else
  2494                          irq = hpriv->irq + i;
  2495

-- 
tejun
