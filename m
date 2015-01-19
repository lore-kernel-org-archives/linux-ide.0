From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: extend PM methods
Date: Mon, 19 Jan 2015 09:15:10 -0500
Message-ID: <20150119141510.GD8140@htj.dyndns.org>
References: <2490673.vl8J86zUxO@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2490673.vl8J86zUxO@wasted.cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Jan 17, 2015 at 02:00:36AM +0300, Sergei Shtylyov wrote:
> From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
> 
> In order to make it possible to restore from hibernation not only in Linux but
> also in e.g. U-Boot, we have to extend  sata_rcar_{suspend|resume}() to {freeze|
> thaw}() PM  methods and implement  the  restore() PM method.
> 
> Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
> [Sergei: killed unused variable, changed the order of initializers, modified
> copyrights, renamed, modified changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.20.

Thanks.

-- 
tejun
