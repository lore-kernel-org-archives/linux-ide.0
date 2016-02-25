From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sata_via: Apply WD workaround only when needed on
 VT6421
Date: Thu, 25 Feb 2016 13:18:22 -0500
Message-ID: <20160225181822.GA6092@mtj.duckdns.org>
References: <1455966113-7320-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455966113-7320-1-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sat, Feb 20, 2016 at 12:01:53PM +0100, Ondrej Zary wrote:
> Currently, workaround for broken WD drives is applied always, slowing
> down all drives. And it has a bug - it's not applied after resume.
> 
> Apply the workaround only if the error really appears
> (SErr == 0x1000500). This allows unaffected drives to run at full speed
> (provided that no affected drive is connected to the controller).
> Also make sure the workaround is re-applied on resume.
...
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
