From: Simon Horman <horms@verge.net.au>
Subject: Re: drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly
 truncated to unsigned type
Date: Tue, 4 Jun 2013 22:18:30 +0900
Message-ID: <20130604131830.GD3068@verge.net.au>
References: <51a59c1b.AMyrU/XAl1VcZ02t%fengguang.wu@intel.com>
 <20130529072447.GC12650@localhost>
 <20130604014521.GN23054@verge.net.au>
 <51ADBBE0.2020408@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51ADBBE0.2020408@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, kbuild-all@01.org, Tejun Heo <tj@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-ide@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 04, 2013 at 02:05:20PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-06-2013 5:45, Simon Horman wrote:
> 
> >could you look into a fix for this?
> 
> >I believe that it is a result of my patch "libata: do not limit R-Car SATA
> >driver to shmobile", which now allows the R-Car SATA driver to be compiled
> >for a (much) wider range of hardware.
> 
>   It is a result of compiling with gcc 4.8. As Tejun wrote, the
> warning has been already fixed and the fix queued in his tree.

Thanks and sorry for the noise.
