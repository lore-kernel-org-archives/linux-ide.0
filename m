From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Mon, 27 Oct 2014 09:04:08 -0400
Message-ID: <20141027130408.GC4436@htj.dyndns.org>
References: <1414368870-31567-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414368870-31567-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 27, 2014 at 09:14:30AM +0900, Simon Horman wrote:
> Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> controller needs to be run with DIPM disabled.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied to libata/for-3.18-fixes w/ stable cc'd.

Thanks.

-- 
tejun
