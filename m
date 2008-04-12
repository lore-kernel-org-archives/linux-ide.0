From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Sat, 12 Apr 2008 10:27:20 +0900
Message-ID: <48000FF8.300@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200804031347.20352.volker.armin.hemmann@tu-clausthal.de> <47FEFFC6.4@gmail.com> <200804111355.55364.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759379AbYDLB1p@vger.kernel.org>
In-Reply-To: <200804111355.55364.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>
List-Id: linux-ide@vger.kernel.org

Volker Armin Hemmann wrote:
> Hi,
> 
>> Aiee.... Can you please try 2.6.25-rc8 with both configurations?  And
>> w/o systemrescuecd?  Just seeing whether things mount properly or not is
>> good enough.  There isn't much risk of losing data.
> 
> 2.6.25-rc8 is a 'no change'. AHCI+pci=nomsi boots, AHCI without hangs.
> with AHCI I also get this:
> 
> [    0.363828] ------------[ cut here ]------------
> [    0.363828] WARNING: at drivers/ata/ahci.c:645 ahci_init_one+0x190/0xa3a()
> [    0.363828] Modules linked in:
> [    0.363828] Pid: 1, comm: swapper Not tainted 2.6.25-rc8 #2

Heh.. that's AHCI_EN not getting set.  Peer, any ideas?  The driver set 
AHCI_EN in the HOST_CTL register but on reading back it's still clear.

Thanks.

-- 
tejun
