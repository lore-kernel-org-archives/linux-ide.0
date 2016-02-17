From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] sata_via: Apply WD workaround only when needed
Date: Wed, 17 Feb 2016 12:51:55 -0500
Message-ID: <20160217175155.GA2626@mtj.duckdns.org>
References: <1455570107-11520-1-git-send-email-linux@rainbow-software.org>
 <20160216214253.GR3741@mtj.duckdns.org>
 <201602162357.52647.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201602162357.52647.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Feb 16, 2016 at 11:57:52PM +0100, Ondrej Zary wrote:
> Guess that I need to read SErr manually?

Yeah, read whatever is necessary.  It's restricted to the controller
anyway.

Thanks.

-- 
tejun
