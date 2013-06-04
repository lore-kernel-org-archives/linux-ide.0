From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly
 truncated to unsigned type
Date: Tue, 04 Jun 2013 14:05:20 +0400
Message-ID: <51ADBBE0.2020408@cogentembedded.com>
References: <51a59c1b.AMyrU/XAl1VcZ02t%fengguang.wu@intel.com> <20130529072447.GC12650@localhost> <20130604014521.GN23054@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130604014521.GN23054@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Fengguang Wu <fengguang.wu@intel.com>, kbuild-all@01.org, Tejun Heo <tj@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-ide@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

Hello.

On 04-06-2013 5:45, Simon Horman wrote:

> could you look into a fix for this?

> I believe that it is a result of my patch "libata: do not limit R-Car SATA
> driver to shmobile", which now allows the R-Car SATA driver to be compiled
> for a (much) wider range of hardware.

   It is a result of compiling with gcc 4.8. As Tejun wrote, the warning 
has been already fixed and the fix queued in his tree.

WBR, Sergei

